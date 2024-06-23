import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/modules/dialog_manager/dialog_manager.dart';
import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:bratacha/services/url_launcher_service/i_url_launcher_service.dart';
import 'package:bratacha/widgets/common/buttons/custom_elevated_button.dart';
import 'package:bratacha/widgets/common/panels/hard_difficulty_panel/hard_difficulty_panel.dart';
import 'package:bratacha/widgets/common/panels/language_panel/language_cubit.dart';
import 'package:bratacha/widgets/common/panels/language_panel/language_panel.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/feedback_panel.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/settings_popup_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    // whole widget should be rebuilt when language is changed
    return BlocBuilder<LanguageCubit, String>(
      builder: (_, __) => Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.settingsTabLabelText),
          actions: [
            SettingsPopupMenuButton(parentContext: context),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16.0),
                Text(context.l10n.settingsTabLanguageLabel),
                const SizedBox(height: 8.0),
                const LanguagePanel(),
                const HardDifficultyPanel(),
                Center(
                  child: CustomElevatedButton(
                    onPressed: () async {
                      final playerDataService = context.read<IPlayerDataService>();
                      final response = await context.read<IDialogService>().requestConfirmDialog(
                            ConfirmDialogRequest(
                              title: context.l10n.resetProgressDialogTitle,
                              description: context.l10n.resetProgressDialogDescription,
                              negativeButtonText: context.l10n.generalNo,
                              positiveButtonText: context.l10n.generalYes,
                            ),
                          );
                      if (response.isPositive) {
                        await playerDataService.reset();
                      }
                    },
                    buttonText: context.l10n.settingsTabResetProgressLabel,
                  ),
                ),
                FeedbackPanel(
                  urlLaucherService: context.read<IUrlLaucherService>(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
