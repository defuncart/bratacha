import 'package:bratacha/localizations.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/dark_mode_cubit.dart';
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
                    Text(AppLocalizations.settingsTabDarkModeLabel),
                    BlocBuilder<DarkModeCubit, bool>(
                      builder: (_, isDarkMode) => Switch(
                        value: isDarkMode,
                        onChanged: (_) => context.bloc<DarkModeCubit>().toggle(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
