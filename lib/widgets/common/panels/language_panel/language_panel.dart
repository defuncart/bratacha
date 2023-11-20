import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/modules/dialog_manager/dialog_manager.dart';
import 'package:bratacha/widgets/common/panels/language_panel/langauge_button.dart';
import 'package:bratacha/widgets/common/panels/language_panel/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguagePanel extends StatelessWidget {
  const LanguagePanel({
    this.presentConfirmationDialog = true,
    Key? key,
  }) : super(key: key);

  final bool presentConfirmationDialog;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
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
                  onPressed: () async {
                    final languageCubit = context.read<LanguageCubit>();

                    if (presentConfirmationDialog) {
                      final response = await context.read<IDialogService>().requestConfirmDialog(
                            ConfirmDialogRequest(
                              title: AppLocalizations.changeLanguageDialogTitle,
                              description: AppLocalizations.changeLanguageDialogDescription,
                              negativeButtonText: AppLocalizations.generalNo,
                              positiveButtonText: AppLocalizations.generalYes,
                            ),
                          );

                      if (!response.isPositive) {
                        return;
                      }
                    }

                    languageCubit.setLanguage(languageCode);
                  },
                  size: size,
                )
            ],
          ),
        );
      },
    );
  }
}
