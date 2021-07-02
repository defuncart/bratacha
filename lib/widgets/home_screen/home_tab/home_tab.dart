import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/managers/level_manager.dart';
import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:bratacha/widgets/common/score.dart';
import 'package:bratacha/widgets/game_screen/game_screen.dart';
import 'package:bratacha/widgets/learn_screen/learn_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final levelManager = context.read<LevelManager>();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.homeTabLabelText),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Score(
                score: context.read<IPlayerDataService>().score,
                color: const Color(0xffFFE391),
                fontSize: 20.0,
              ),
            ),
          ),
        ],
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
                    child: _LevelButton(
                      levelIndex: i,
                      isLevelUnlocked: levelManager.isLevelUnlocked(i),
                      pointsRequired: levelManager.scoreToUnlock(i),
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

class _LevelButton extends StatelessWidget {
  final bool isLevelUnlocked;
  final int levelIndex;
  final int pointsRequired;

  const _LevelButton({
    Key key,
    @required this.isLevelUnlocked,
    @required this.levelIndex,
    @required this.pointsRequired,
  })  : assert(isLevelUnlocked != null),
        assert(levelIndex != null),
        assert(pointsRequired != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Opacity(
        opacity: isLevelUnlocked ? 1 : 0.4,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.generalLevelLabel(level: levelIndex + 1),
                      style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
                    ),
                    if (!isLevelUnlocked)
                      Score(
                        score: pointsRequired,
                        color: Theme.of(context).accentColor,
                        fontSize: 16.0,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: isLevelUnlocked
          ? () => Navigator.of(context).pushReplacementNamed(
                GameScreen.routeName,
                arguments: GameScreenArguments(level: levelIndex),
              )
          : null,
    );
  }
}
