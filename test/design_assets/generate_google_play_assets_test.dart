import 'package:app_store_screenshots/app_store_screenshots.dart';
import 'package:bratacha/configs/app_config.dart';
import 'package:bratacha/configs/app_themes.dart';
import 'package:bratacha/intl/generated/localizations.dart';
import 'package:bratacha/widgets/common/panels/language_panel/langauge_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  generateGooglePlayFeatureGraphic(
    locales: AppLocalizations.supportedLocales,
    onBuildGraphic: (locale) => FutureBuilder(
      future: AppLocalizations.delegate.load(locale),
      builder: (context, snapshot) => GooglePlayFeatureGraphics(
        text: snapshot.data!.assetgenTagline,
      ),
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
                  spacing: 24,
                  children: AppConfig.languageOrder
                      .map(
                        (languageCode) => LanguageButton(
                          languageCode: languageCode,
                          isSelected: true,
                          onPressed: () {},
                          size: 64,
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Bratacha',
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 128,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  text,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w300,
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
