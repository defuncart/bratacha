import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/managers/level_manager.dart';
import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:bratacha/widgets/common/score.dart';
import 'package:bratacha/widgets/game_screen/game_screen.dart';
import 'package:bratacha/widgets/learn_screen/learn_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final levelManager = context.read<LevelManager>();

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.homeTabLabelText),
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
                const SizedBox(height: 4.0),
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
                    context.l10n.homeTabLeanFlagsButtonText,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
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
  const _LevelButton({
    required this.isLevelUnlocked,
    required this.levelIndex,
    required this.pointsRequired,
  });

  final bool isLevelUnlocked;
  final int levelIndex;
  final int pointsRequired;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLevelUnlocked
          ? () => Navigator.of(context).pushReplacementNamed(
                GameScreen.routeName,
                arguments: GameScreenArguments(level: levelIndex),
              )
          : null,
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
                      context.l10n.generalLevelLabel(levelIndex + 1),
                      style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
                    ),
                    if (!isLevelUnlocked)
                      Score(
                        score: pointsRequired,
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 16.0,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
