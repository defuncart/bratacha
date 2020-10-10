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
                SizedBox(height: 4.0),
                for (var i = 0; i < levelManager.numberLevels; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: GestureDetector(
                      child: Card(
                        color: levelManager.isLevelUnlocked(i)
                            ? Theme.of(context).cardColor
                            : Theme.of(context).cardColor.withAlpha(128),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                AppLocalizations.generalLevelLabel(level: i + 1),
                                style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: levelManager.isLevelUnlocked(i)
                          ? () => Navigator.of(context).pushNamed(
                                GameScreen.routeName,
                                arguments: GameScreenArguments(level: i),
                              )
                          : null,
                    ),
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
