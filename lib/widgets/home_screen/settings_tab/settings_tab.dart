import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/hard_difficulty_panel.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/language_cubit.dart';
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(AppLocalizations.settingsTabLanguageLabel),
                    BlocBuilder<LanguageCubit, String>(
                      builder: (_, language) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (final locale in AppLocalizationsDelegate.supportedLocals)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: _LanguageButton(
                                label: locale.languageCode,
                                isSelected: locale.languageCode == language,
                                onPressed: () => context.bloc<LanguageCubit>().setLanguage(locale.languageCode),
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: HardDifficultyPanel(),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) => Theme.of(context).accentColor),
                ),
                onPressed: () => context.repository<IPlayerDataService>().reset(),
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

class _LanguageButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final void Function() onPressed;

  const _LanguageButton({
    Key key,
    @required this.label,
    @required this.isSelected,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: isSelected ? Theme.of(context).accentColor : Theme.of(context).accentColor.withAlpha(128),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            label.toUpperCase(),
            style: TextStyle(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
