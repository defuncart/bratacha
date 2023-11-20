import 'package:flutter/material.dart';

abstract class AppThemes {
  static final theme = ThemeData.dark().copyWith(
    colorScheme: const ColorScheme.dark().copyWith(
      secondary: _AppColors.accent,
    ),
    scaffoldBackgroundColor: _AppColors.primary,
    appBarTheme: const AppBarTheme(
      color: _AppColors.primaryDark,
      elevation: 0,
    ),
    cardColor: _AppColors.card,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _AppColors.accent,
      ),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: _AppColors.primary,
    ),
  );
}

class _AppColors {
  static const primary = Color(0xff3A4750);
  static const primaryDark = Color(0xff303841);
  static const accent = Color(0xff00adb5);
  static const card = Color(0xffeeeeee);
}
