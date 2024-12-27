import 'package:app_store_screenshots/app_store_screenshots.dart';
import 'package:bratacha/configs/app_themes.dart';
import 'package:bratacha/widgets/common/icons/app_icon.dart';
import 'package:flutter/material.dart';

void main() {
  generateAppIcon(
    onBuildIcon: (size) => Theme(
      data: AppThemes.theme,
      child: AppIcon(
        size: size,
      ),
    ),
  );

  generateAppIconAndroidForeground(
    padding: EdgeInsets.zero,
    onBuildIcon: (size) => AppIcon(
      size: size,
      hasTransparentBackground: true,
    ),
  );
}
