import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:users/models/user_model.dart';
import 'package:users/providers/users_provider.dart';
import 'package:users/services/database_service.dart';

void main() {
  // Setup sqflite_ffi for local unit testing
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  late UsersProvider usersProvider;
  late Database db;

  setUp(() async {
    // Initialize in-memory database
    db = await openDatabase(inMemoryDatabasePath, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE users (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          email TEXT UNIQUE NOT NULL,
          password TEXT NOT NULL,
          status TEXT NOT NULL
        )
      ''');
    });

    // Inject test database
    DatabaseService.setTestDatabase(db);
    
    usersProvider = UsersProvider();
  });

  tearDown(() async {
    await db.close();
    DatabaseService.setTestDatabase(null);
  });

  group('UsersProvider Unit Tests', () {
    test('addUser should persist a user and update the list', () async {
      final user = UserModel(
        name: 'Test User',
        email: 'test@example.com',
        password: 'password',
        status: 'Ativo',
      );

      await usersProvider.addUser(user);

      expect(usersProvider.users.length, 1);
      expect(usersProvider.users.first.name, 'Test User');
      expect(usersProvider.users.first.email, 'test@example.com');
    });

    test('addUser should handle duplicate email errors', () async {
      final user = UserModel(
        name: 'Test User 1',
        email: 'duplicate@example.com',
        password: 'password',
        status: 'Ativo',
      );

      await usersProvider.addUser(user);

      final user2 = UserModel(
        name: 'Test User 2',
        email: 'duplicate@example.com',
        password: 'password',
        status: 'Ativo',
      );

      await usersProvider.addUser(user2);

      expect(usersProvider.errorMessage, isNotNull);
      expect(usersProvider.users.length, 1);
    });

    test('updateUser should modify an existing user and update the list', () async {
      final user = UserModel(
        name: 'Initial Name',
        email: 'update@example.com',
        password: 'password',
        status: 'Ativo',
      );

      await usersProvider.addUser(user);
      final createdUser = usersProvider.users.first;

      final updatedUser = UserModel(
        id: createdUser.id,
        name: 'Updated Name',
        email: 'update@example.com',
        password: 'newpassword',
        status: 'Inativo',
      );

      await usersProvider.updateUser(updatedUser);

      expect(usersProvider.users.first.name, 'Updated Name');
      expect(usersProvider.users.first.status, 'Inativo');
    });
  });
}
