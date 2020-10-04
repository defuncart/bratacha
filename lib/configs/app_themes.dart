import 'package:flutter/material.dart';

abstract class AppThemes {
  static final theme = ThemeData.dark().copyWith(
    accentColor: _AppColors.accent,
    scaffoldBackgroundColor: _AppColors.primary,
    appBarTheme: AppBarTheme(
      color: _AppColors.primaryDark,
    ),
  );
}

class _AppColors {
  static const primary = Color(0xff3A4750);
  static const primaryDark = Color(0xff303841);
  static const accent = Color(0xff00adb5);
  // static const text = Color(0xffeeeeee);
}
