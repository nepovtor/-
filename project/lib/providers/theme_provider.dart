import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider managing the application's theme mode and persistence.
class ThemeProvider extends ChangeNotifier {
  static const _key = 'theme_mode';
  ThemeMode _themeMode = ThemeMode.system;

  ThemeProvider() {
    _loadTheme();
  }

  ThemeMode get themeMode => _themeMode;

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(_key);
    if (index != null) {
      _themeMode = ThemeMode.values[index];
      notifyListeners();
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, mode.index);
  }
}

