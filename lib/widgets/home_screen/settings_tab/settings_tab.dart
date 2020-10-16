import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/modules/dialog_manager/dialog_manager.dart';
import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:bratacha/widgets/common/panels/hard_difficulty_panel/hard_difficulty_panel.dart';
import 'package:bratacha/widgets/common/panels/language_panel/language_panel.dart';
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
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: LanguagePanel(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: HardDifficultyPanel(),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) => Theme.of(context).accentColor),
                ),
                onPressed: () async {
                  final response = await context.repository<IDialogService>().requestConfirmDialog(ConfirmDialogRequest(
                        title: AppLocalizations.resetProgressDialogTitle,
                        description: AppLocalizations.resetProgressDialogDescription,
                        negativeButtonText: AppLocalizations.generalNo,
                        positiveButtonText: AppLocalizations.generalYes,
                      ));
                  if (response == ConfirmDialogResponseType.positive) {
                    await context.repository<IPlayerDataService>().reset();
                  }
                },
                child: Text(
                  AppLocalizations.settingsTabResetProgressLabel,
                  style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
