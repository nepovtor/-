import 'package:flutter/material.dart';

import '../models/user.dart';
import '../services/auth_service.dart';

/// Provider exposing authentication state to the widget tree.
class AuthProvider extends ChangeNotifier {
  final AuthService _service = AuthService();
  User? currentUser;

  bool get isLoggedIn => currentUser != null;

  Future<void> login(String name) async {
    currentUser = await _service.login(name);
    notifyListeners();
  }

  Future<void> logout() async {
    await _service.logout();
    currentUser = null;
    notifyListeners();
  }
}

