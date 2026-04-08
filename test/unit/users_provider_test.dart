import 'package:flutter_test/flutter_test.dart';
import 'package:users/providers/users_provider.dart';
import 'package:users/models/user_model.dart';
import 'package:users/services/database_service.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  group('UsersProvider Unit Tests', () {
    late UsersProvider provider;
    late Database db;

    Future<Database> createTestDatabase() async {
      final db = await openDatabase(
        inMemoryDatabasePath,
        version: 1,
        onCreate: (db, version) async {
          await db.execute('''
            CREATE TABLE users (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT NOT NULL,
              email TEXT UNIQUE NOT NULL,
              password TEXT NOT NULL,
              status TEXT NOT NULL
            )
          ''');
          // Seed mock data
          await db.insert('users', {
            'name': 'Admin User',
            'email': 'admin@admin.com',
            'password': '12345',
            'status': 'Ativo',
          });
          await db.insert('users', {
            'name': 'João Silva',
            'email': 'joao@example.com',
            'password': '123',
            'status': 'Ativo',
          });
        },
      );
      return db;
    }

    setUp(() async {
      db = await createTestDatabase();
      DatabaseService.setTestDatabase(db);
      provider = UsersProvider();
    });

    tearDown(() async {
      await db.close();
      DatabaseService.setTestDatabase(null);
    });

    test('Initial state should be empty and not loading', () {
      expect(provider.users, isEmpty);
      expect(provider.isLoading, isFalse);
    });

    test('fetchUsers should load users from database', () async {
      await provider.fetchUsers();
      expect(provider.users, isNotEmpty);
      expect(provider.isLoading, isFalse);
      expect(provider.users.any((u) => u.email == 'admin@admin.com'), isTrue);
    });

    test('addUser should add a new user and refresh the list', () async {
      final newUser = UserModel(
        name: 'Test Add',
        email: 'test_add@example.com',
        password: '123',
      );
      await provider.addUser(newUser);
      expect(provider.users.any((u) => u.email == 'test_add@example.com'), isTrue);
    });

    test('updateUser should modify an existing user and refresh', () async {
      await provider.fetchUsers();
      final target = provider.users.firstWhere((u) => u.email == 'joao@example.com');
      final updatedUser = target.copyWith(name: 'Updated Name');
      
      await provider.updateUser(updatedUser);
      
      final checked = provider.users.firstWhere((u) => u.id == target.id);
      expect(checked.name, 'Updated Name');
    });

    test('deleteUser should remove user and refresh', () async {
      await provider.fetchUsers();
      final initialCount = provider.users.length;
      final target = provider.users.firstWhere((u) => u.email == 'joao@example.com');
      
      await provider.deleteUser(target.id!);
      
      expect(provider.users.length, initialCount - 1);
      expect(provider.users.any((u) => u.id == target.id), isFalse);
    });
  });

  tearDownAll(() {
    DatabaseService.setTestDatabase(null);
  });
}
