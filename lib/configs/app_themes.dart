import 'package:flutter/material.dart';

abstract class AppThemes {
  static final theme = ThemeData.dark().copyWith(
    colorScheme: const ColorScheme.dark().copyWith(
      primary: _AppColors.primary,
      onPrimary: _AppColors.primaryDark,
      secondary: _AppColors.accent,
      surface: _AppColors.card,
      surfaceContainerLow: _AppColors.card,
    ),
    scaffoldBackgroundColor: _AppColors.primary,
    appBarTheme: const AppBarTheme(
      color: _AppColors.primaryDark,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _AppColors.accent,
      ),
    ),
    dialogTheme: const DialogTheme(
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
  static const card = Color(0xffeeeeee);
}
