import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../../lib/services/auth_service.dart';
import '../../lib/providers/users_provider.dart';
import '../../lib/ui/screens/login_screen.dart';

void main() {
  // Initialize FFI for local machine tests
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  testWidgets('Initial login screen displays email and password fields in pt-BR', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthService()),
          ChangeNotifierProvider(create: (_) => UsersProvider()),
        ],
        child: const MaterialApp(home: LoginScreen()),
      ),
    );

    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Senha'), findsOneWidget);
    expect(find.text('RH'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    // Find 'Entrar' inside the button specifically
    expect(
      find.descendant(
        of: find.byType(ElevatedButton),
        matching: find.text('Entrar'),
      ),
      findsOneWidget,
    );
  });


}
