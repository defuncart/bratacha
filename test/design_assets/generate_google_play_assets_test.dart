import 'dart:io';

import 'package:app_store_screenshots/app_store_screenshots.dart';
import 'package:bratacha/configs/app_themes.dart';
import 'package:bratacha/extensions/iterable_widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  final text = {
    const Locale('en'): 'A fun flag quiz game!',
    const Locale('be'): 'Вясёлая віктарына са сцягам!',
    const Locale('cy'): 'A fun flag quiz game!',
    const Locale('ga'): 'A fun flag quiz game!',
  };

  for (final locale in AppLocalizations.supportedLocales) {
    assert(text.keys.contains(locale));
  }

  generateGooglePlayFeatureGraphic(
    locales: AppLocalizations.supportedLocales,
    onBuildGraphic: (locale) => GooglePlayFeatureGraphics(
      text: text[locale] ?? '',
    ),
  );
}

@visibleForTesting
class GooglePlayFeatureGraphics extends StatelessWidget {
  const GooglePlayFeatureGraphics({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppThemes.theme,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: ['en', 'be', 'cy', 'ga']
                      // TODO: Migrate to LanguageButton & load assets in setup
                      .map((countryCode) => ClipOval(
                            child: SvgPicture.file(
                              File('assets/languages/$countryCode.svg'),
                              width: 48,
                              height: 48,
                            ),
                          ))
                      .intersperse(const SizedBox(width: 16))
                      .toList(),
                ),
                const Text(
                  'Bratacha',
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 128,
                  ),
                ),
                Text(
                  text,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 48,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
