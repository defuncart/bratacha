import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/widgets/common/panels/language_panel/langauge_button.dart';
import 'package:bratacha/widgets/common/panels/language_panel/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguagePanel extends StatelessWidget {
  final bool showTextLabel;

  const LanguagePanel({
    Key key,
    this.showTextLabel = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (showTextLabel)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(AppLocalizations.settingsTabLanguageLabel),
          ),
        LayoutBuilder(
          builder: (_, constraints) {
            final languageCodes = AppLocalizationsDelegate.supportedLocals.map((locale) => locale.languageCode);
            final size = (constraints.maxWidth * 0.75) / languageCodes.length;

            return BlocBuilder<LanguageCubit, String>(
              builder: (_, language) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (final languageCode in languageCodes)
                    LanguageButton(
                      languageCode: languageCode,
                      isSelected: languageCode == language,
                      onPressed: () => context.bloc<LanguageCubit>().setLanguage(languageCode),
                      size: size,
                    )
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
