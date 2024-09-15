import 'package:bratacha/configs/app_config.dart';
import 'package:bratacha/extensions/iterable_widget_extension.dart';
import 'package:bratacha/intl/country_localizations.dart';
import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/widgets/common/flag.dart';
import 'package:bratacha/widgets/game_screen/game_screen.dart';
import 'package:bratacha/widgets/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ResultsScreenArguments {
  final int level;
  final double correctPercentage;
  final bool canPlayNextLevel;
  final bool nextLevelUnlocked;
  final List<String> incorrectIds;

  ResultsScreenArguments({
    required this.level,
    required this.correctPercentage,
    required this.canPlayNextLevel,
    required this.nextLevelUnlocked,
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
    final correctPercentage = args.correctPercentage;
    final canPlayNextLevel = args.canPlayNextLevel;
    final nextLevelUnlocked = args.nextLevelUnlocked;

    final trophyScore = correctPercentage >= AppConfig.percentageToOpenNextLevel;
    final headlineColor = trophyScore ? const Color(0xffFFE391) : Theme.of(context).colorScheme.secondary;
    final headlineText = trophyScore ? context.l10n.resultsCongratulations : context.l10n.resultsWellDone;
    final headlineIcon = trophyScore ? MdiIcons.trophyVariant : MdiIcons.medalOutline;

    if (nextLevelUnlocked && _hasShownPopover[level] == null) {
      // ignore_for_file: use_build_context_synchronously
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
              // middle
              if (correctPercentage == 1)
                const PerfectRoundWidget()
              else
                MistakesScrollList(
                  incorrectIds: args.incorrectIds,
                ),
              const Spacer(),
              // actions
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

@visibleForTesting
class PerfectRoundWidget extends StatelessWidget {
  const PerfectRoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          MdiIcons.partyPopper,
          size: 48,
          color: Theme.of(context).colorScheme.secondary,
        ),
        Text(
          context.l10n.resultsPerfectRound,
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
    );
  }
}

@visibleForTesting
class MistakesScrollList extends StatelessWidget {
  const MistakesScrollList({
    super.key,
    required this.incorrectIds,
  });

  final List<String> incorrectIds;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        // add spacers left/right
        itemCount: incorrectIds.length + 2,
        itemBuilder: (context, index) {
          if (index == 0 || index == incorrectIds.length + 1) {
            return const SizedBox(width: 4);
          }

          final adjustedIndex = index - 1;
          final countryId = incorrectIds[adjustedIndex];
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
    );
  }
}
