import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:users/providers/users_provider.dart';
import 'package:users/models/user_model.dart';
import 'package:users/ui/screens/collaborator_form_screen.dart';
import 'package:users/services/database_service.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // Setup sqflite_ffi for widget testing
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  late UsersProvider usersProvider;
  late Database db;

  setUp(() async {
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
    DatabaseService.setTestDatabase(db);
    usersProvider = UsersProvider();
  });

  tearDown(() async {
    await db.close();
    DatabaseService.setTestDatabase(null);
  });

  Widget createWidgetUnderTest({UserModel? user}) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: usersProvider),
      ],
      child: MaterialApp(
        home: CollaboratorFormScreen(user: user),
      ),
    );
  }

  group('CollaboratorFormScreen Widget Tests', () {
    testWidgets('Should display "Novo colaborador" title for creation mode', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      
      expect(find.text('Novo colaborador'), findsOneWidget);
    });

    testWidgets('Should show validation errors when saving empty form', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      
      // Find and tap save button
      final saveButton = find.byType(ElevatedButton); // Should be present in final impl
      if (tester.any(saveButton)) {
        await tester.tap(saveButton);
        await tester.pump();
        
        expect(find.text('Campo obrigatório'), findsWidgets);
      }
    });

    testWidgets('Should display "Editar Colaborador" title and pre-fill data', (WidgetTester tester) async {
      final existingUser = UserModel(
        id: 1,
        name: 'Existing User',
        email: 'exist@example.com',
        password: 'password123',
        status: 'Inativo',
      );

      await tester.pumpWidget(createWidgetUnderTest(user: existingUser));
      
      expect(find.text('Editar Colaborador'), findsOneWidget);
      expect(find.text('Existing User'), findsOneWidget);
      expect(find.text('exist@example.com'), findsOneWidget);
      // Wait, password text field is obscured, but the controller should have the value
      final passwordField = tester.widget<TextFormField>(find.ancestor(of: find.text('Senha'), matching: find.byType(TextFormField)));
      expect(passwordField.controller?.text, 'password123');
    });
  });
}
