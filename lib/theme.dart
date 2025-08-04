import 'package:flutter/material.dart';
import 'core/constants/colors.dart';

/// Centralized application theme.
class AppTheme {
  /// Light theme used throughout the app.
  static ThemeData get lightTheme => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      );
}
