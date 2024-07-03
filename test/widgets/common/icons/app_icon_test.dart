import 'package:app_store_screenshots/app_store_screenshots.dart';
import 'package:bratacha/configs/app_themes.dart';
import 'package:bratacha/widgets/common/icons/app_icon.dart';
import 'package:flutter/material.dart';

void main() {
  generateAppIcon(
    onBuildIcon: () => Theme(
      data: AppThemes.theme,
      child: const AppIcon(),
    ),
  );

  generateAppIconAndroidForeground(
    onBuildIcon: () => const AppIcon(
      size: 512 - 80 * 2,
      hasTransparentBackground: true,
    ),
  );
}
