import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/modules/dialog_manager/dialog_manager.dart';
import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:bratacha/services/app_info_service/i_app_info_service.dart';
import 'package:bratacha/widgets/common/buttons/custom_elevated_button.dart';
import 'package:bratacha/widgets/common/panels/data_privacy_panel.dart';
import 'package:bratacha/widgets/common/panels/hard_difficulty_panel/hard_difficulty_panel.dart';
import 'package:bratacha/widgets/common/panels/language_panel/language_panel.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/credits_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.settingsTabLabelText),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 16.0),
              Text(AppLocalizations.settingsTabLanguageLabel),
              SizedBox(height: 8.0),
              LanguagePanel(),
              HardDifficultyPanel(),
              Center(
                child: CustomElevatedButton(
                  onPressed: () async {
                    final response = await context.repository<IDialogService>().requestConfirmDialog(
                          ConfirmDialogRequest(
                            title: AppLocalizations.resetProgressDialogTitle,
                            description: AppLocalizations.resetProgressDialogDescription,
                            negativeButtonText: AppLocalizations.generalNo,
                            positiveButtonText: AppLocalizations.generalYes,
                          ),
                        );
                    if (response.isPositive) {
                      await context.repository<IPlayerDataService>().reset();
                    }
                  },
                  buttonText: AppLocalizations.settingsTabResetProgressLabel,
                ),
              ),
              Center(
                child: CustomElevatedButton(
                  buttonText: AppLocalizations.settingsTabDataPrivacyLabel,
                  onPressed: () async {
                    final response = await context.repository<IDialogService>().requestCustomDialog(
                          CustomDialogRequest(
                            title: AppLocalizations.dataPrivacyDialogTitle,
                            content: DataPrivacyPanel(),
                            buttonTexts: [
                              AppLocalizations.dataPrivacyDialogViewLicensesLabel,
                              AppLocalizations.generalClose,
                            ],
                          ),
                        );

                    if (response.buttonIndexPressed == 0) {
                      final appInfoService = context.repository<IAppInfoService>();
                      showLicensePage(
                        context: context,
                        applicationName: appInfoService.applicationName,
                        applicationVersion: appInfoService.applicationVersion,
                        applicationIcon: appInfoService.applicationIcon,
                        applicationLegalese: appInfoService.applicationLegalese,
                      );
                    }
                  },
                ),
              ),
              Center(
                child: CustomElevatedButton(
                  buttonText: AppLocalizations.settingsTabCreditsLabel,
                  onPressed: () async => await context.repository<IDialogService>().requestCustomDialog(
                        CustomDialogRequest(
                          title: AppLocalizations.creditsDialogTitle,
                          content: CreditsPanel(),
                          buttonTexts: [
                            AppLocalizations.generalClose,
                          ],
                        ),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
