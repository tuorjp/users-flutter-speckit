import 'package:flutter/foundation.dart';
import '../models/user.dart';
import 'database_service.dart';

class AuthService with ChangeNotifier {
  final DatabaseService _dbService = DatabaseService();
  User? _currentUser;
  bool _isLoggedIn = false;

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;

  Future<bool> login(String email, String password) async {
    final user = await _dbService.getUserByEmail(email);

    if (user != null && user.password == password) {
      _currentUser = user;
      _isLoggedIn = true;
      notifyListeners();
      return true;
    }

    _currentUser = null;
    _isLoggedIn = false;
    notifyListeners();
    return false;
  }

  void logout() {
    _currentUser = null;
    _isLoggedIn = false;
    notifyListeners();
  }
}
