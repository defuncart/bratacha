import 'package:bratacha/configs/progress_config.dart';
import 'package:bratacha/extensions/iterable_widget_extension.dart';
import 'package:bratacha/intl/country_localizations.dart';
import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/managers/level_manager.dart';
import 'package:bratacha/widgets/common/flag.dart';
import 'package:bratacha/widgets/game_screen/game_screen.dart';
import 'package:bratacha/widgets/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ResultsScreenArguments {
  final int level;
  final double levelProgressBefore;
  final double levelProgressAfter;
  final int numberRounds;
  final int correctAnswers;
  final List<String> incorrectIds;

  ResultsScreenArguments({
    required this.level,
    required this.levelProgressBefore,
    required this.levelProgressAfter,
    required this.numberRounds,
    required this.correctAnswers,
    required this.incorrectIds,
  });
}

final _hasShownPopover = <int, bool>{};

class ResultsScreen extends StatelessWidget {
  static const routeName = 'ResultsScreen';

  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as ResultsScreenArguments;
    final level = args.level;
    final numberLevels = context.read<LevelManager>().numberLevels;
    final canPlayNextLevel =
        args.levelProgressAfter >= ProgressConfig.percentageToOpenNextLevel && level < numberLevels - 1;
    final nextLevelUnlocked = canPlayNextLevel && context.read<LevelManager>().progressForLevel(level + 1) == 0;
    final correctPercentage = args.correctAnswers / args.numberRounds;

    final goodScore = correctPercentage >= ProgressConfig.percentageToOpenNextLevel;
    final headlineColor = goodScore ? const Color(0xffFFE391) : Theme.of(context).colorScheme.secondary;
    final headlineText = goodScore ? context.l10n.resultsCongratulations : context.l10n.resultsWellDone;
    final headlineIcon = goodScore ? MdiIcons.trophyVariant : MdiIcons.trophyAward;

    if (nextLevelUnlocked && _hasShownPopover[level] == null) {
      Future.microtask(
        () => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
              bottom: MediaQuery.sizeOf(context).height - MediaQuery.paddingOf(context).top - kToolbarHeight - 60,
              left: MediaQuery.sizeOf(context).width * 0.25,
              right: MediaQuery.sizeOf(context).width * 0.25,
            ),
            content: Text(
              context.l10n.resultsNextLevelUnlocked,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );
      _hasShownPopover[level] = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.generalLevelLabel(level + 1),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              // headline
              Icon(
                headlineIcon,
                size: 92,
                color: headlineColor,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  headlineText,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall?.apply(
                        color: headlineColor,
                      ),
                ),
              ),
              const Spacer(),
              if (correctPercentage == 1)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      MdiIcons.partyPopper,
                      size: 48,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    Text(
                      'Perfect round!',
                      style: Theme.of(context).textTheme.headlineMedium?.apply(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                    Icon(
                      MdiIcons.partyPopper,
                      size: 48,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ].intersperse(const SizedBox(width: 8)),
                )
              else
                SizedBox(
                  height: 96,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    // add spacers left/right
                    itemCount: args.incorrectIds.length + 2,
                    itemBuilder: (context, index) {
                      if (index == 0 || index == args.incorrectIds.length + 1) {
                        return const SizedBox(width: 4);
                      }

                      final adjustedIndex = index - 1;
                      final countryId = args.incorrectIds[adjustedIndex];
                      return Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Flag(
                            countryId,
                            size: 96,
                          ),
                          Positioned(
                            bottom: 2,
                            child: Container(
                              constraints: const BoxConstraints(maxWidth: 96 - 4),
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Theme.of(context).scaffoldBackgroundColor,
                              ),
                              child: Text(
                                CountryLocalizations.getString(countryId),
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                  ),
                ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pushReplacementNamed(HomeScreen.routeName),
                    icon: const Icon(Icons.home),
                    iconSize: kMinInteractiveDimension,
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pushReplacementNamed(
                      GameScreen.routeName,
                      arguments: GameScreenArguments(level: level),
                    ),
                    icon: const Icon(Icons.sync),
                    iconSize: kMinInteractiveDimension,
                  ),
                  if (canPlayNextLevel)
                    IconButton(
                      onPressed: () => Navigator.of(context).pushReplacementNamed(
                        GameScreen.routeName,
                        arguments: GameScreenArguments(level: level + 1),
                      ),
                      icon: const Icon(Icons.arrow_right_alt),
                      iconSize: kMinInteractiveDimension,
                    ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
