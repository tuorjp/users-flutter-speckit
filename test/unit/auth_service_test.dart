import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../../lib/services/auth_service.dart';

void main() {
  // Initialize FFI for local machine tests
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  group('AuthService Tests', () {
    late AuthService authService;

    setUp(() {
      authService = AuthService();
    });

    test('Initial state: user is not logged in', () {
      expect(authService.isLoggedIn, false);
      expect(authService.currentUser, isNull);
    });

    // These will fail until AuthService is implemented (RED Phase)
    test('Successful login with valid credentials', () async {
      // Assuming DatabaseService mock/seed is handled in the actual implementation
      bool result = await authService.login('admin@admin.com', '12345');
      expect(result, true);
      expect(authService.isLoggedIn, true);
    });

    test('Failed login with invalid credentials', () async {
      bool result = await authService.login('wrong@email.com', 'wrong');
      expect(result, false);
      expect(authService.isLoggedIn, false);
    });
  });
}
