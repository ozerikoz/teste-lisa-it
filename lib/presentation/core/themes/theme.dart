import 'package:flutter/material.dart';
import 'package:teste_lisa_it/presentation/core/themes/colors.dart';

/// A class that defines the app's theme.
abstract class AppTheme {
  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColors.lightColorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.black1,
        foregroundColor: AppColors.white1,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.white1,
          backgroundColor: AppColors.black1,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.black1),
        displayMedium: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.black1),
        titleLarge: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.black1),
        bodyLarge: TextStyle(fontSize: 16, color: AppColors.black1),
        bodyMedium: TextStyle(fontSize: 14, color: AppColors.black1),
      ),
    );
  }

  // Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColors.darkColorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.black1,
        foregroundColor: AppColors.white1,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.black1,
          backgroundColor: AppColors.white1,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.white1),
        displayMedium: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.white1),
        titleLarge: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.white1),
        bodyLarge: TextStyle(fontSize: 16, color: AppColors.white1),
        bodyMedium: TextStyle(fontSize: 14, color: AppColors.white1),
      ),
    );
  }
}
