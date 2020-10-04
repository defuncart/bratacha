import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/managers/level_manager.dart';
import 'package:bratacha/widgets/game_screen/game_screen.dart';
import 'package:bratacha/widgets/learn_screen/learn_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final levelManager = context.repository<LevelManager>();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.homeTabLabelText),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                    for (var i = 0; i < levelManager.numberLevels; i++)
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith((states) => Theme.of(context).accentColor),
                        ),
                        onPressed: () => Navigator.of(context).pushNamed(
                          GameScreen.routeName,
                          arguments: GameScreenArguments(level: i),
                        ),
                        child: Text(
                          AppLocalizations.homeTabLevelButtonText(level: i + 1),
                          style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
                        ),
                      ),
                  ],
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pushNamed(LearnScreen.routeName),
                  child: Text(
                    AppLocalizations.homeTabLeanFlagsButtonText,
                    style: TextStyle(color: Theme.of(context).accentColor),
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
