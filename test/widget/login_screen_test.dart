import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../../lib/services/auth_service.dart';
import '../../lib/ui/screens/login_screen.dart';

void main() {
  // Initialize FFI for local machine tests
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  testWidgets('Initial login screen displays email and password fields', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AuthService(),
        child: const MaterialApp(home: LoginScreen()),
      ),
    );

    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    // Find 'Login' inside the button specifically
    expect(
      find.descendant(
        of: find.byType(ElevatedButton),
        matching: find.text('Login'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('Login with admin credentials shows success snackbar', (WidgetTester tester) async {
    // Note: In real app, DatabaseService mock seed would apply
    // This RED phase assumes common components are available.
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AuthService(),
        child: const MaterialApp(home: LoginScreen()),
      ),
    );

    await tester.enterText(find.byType(TextField).at(0), 'admin@admin.com');
    await tester.enterText(find.byType(TextField).at(1), '12345');
    await tester.tap(
      find.descendant(
        of: find.byType(ElevatedButton),
        matching: find.text('Login'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Login successful'), findsOneWidget);
  });
}
