import '../models/user.dart';

/// Basic authentication service used by the demo application.
class AuthService {
  /// Simulates a login request.
  Future<User> login(String name) async {
    // Simulate a network delay so that UI can show progress indicators.
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return User(id: name.toLowerCase(), name: name, isLeader: true);
  }

  /// Logs out the current user. In a real app this would clear tokens.
  Future<void> logout() async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
  }
}

