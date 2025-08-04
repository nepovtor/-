import 'package:flutter/material.dart';
import 'core/constants/colors.dart';

/// Centralized application theme.
class AppTheme {
  /// Light theme used throughout the app.
  static ThemeData get lightTheme => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      );

  /// Dark theme following the same color scheme.
  static ThemeData get darkTheme => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      );
}
