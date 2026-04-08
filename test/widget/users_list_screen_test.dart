import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:users/providers/users_provider.dart';
import 'package:users/ui/screens/users_list_screen.dart';
import 'package:users/ui/widgets/user_list_item.dart';
import 'package:users/services/database_service.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

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
      },
    );
    return db;
  }

  Widget createWidgetUnderTest() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UsersProvider()),
      ],
      child: const MaterialApp(
        home: UsersListScreen(),
      ),
    );
  }

  testWidgets('UsersListScreen shows list of users after loading', (WidgetTester tester) async {
    final db = await createTestDatabase();
    DatabaseService.setTestDatabase(db);

    await tester.pumpWidget(createWidgetUnderTest());

    // Initially might show a loading spinner
    // Let the Future resolve.
    await tester.pump(); // Start the initState call
    // Process async work
    for (int i = 0; i < 5; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }

    expect(find.text('Cadastro de colaboradores'), findsOneWidget);
    
    // Check if the mock data admin is loaded
    expect(find.byType(UserListItem), findsWidgets);
    expect(find.text('Admin User'), findsOneWidget);

    await db.close();
    DatabaseService.setTestDatabase(null);
  });
}
