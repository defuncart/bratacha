import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class AppThemes {
  static final theme = ThemeData.dark().copyWith(
    colorScheme: const ColorScheme.dark().copyWith(
      primary: _AppColors.primary,
      onPrimary: _AppColors.primaryDark,
      secondary: _AppColors.accent,
      surface: _AppColors.card,
      onSurface: _AppColors.card,
      surfaceContainerLow: _AppColors.card,
      error: _AppColors.error,
    ),
    scaffoldBackgroundColor: _AppColors.primary,
    appBarTheme: const AppBarTheme(
      color: _AppColors.primaryDark,
      foregroundColor: _AppColors.card,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: _AppColors.primary,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: _AppColors.primaryDark,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _AppColors.accent,
      ),
    ),
    dialogTheme: const DialogThemeData(
      backgroundColor: _AppColors.primary,
    ),
    // _packagesView from about.dart uses card color for background color
    cardColor: _AppColors.primary,
  );
}

class _AppColors {
  static const primary = Color(0xff3A4750);
  static const primaryDark = Color(0xff303841);
  static const accent = Color(0xff00adb5);
  static const error = Color(0xffFF5449);
  static const card = Color(0xffeeeeee);
}
