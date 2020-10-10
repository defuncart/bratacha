import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/managers/level_manager.dart';
import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:bratacha/services/game_service.dart';
import 'package:bratacha/services/i_game_service.dart';
import 'package:bratacha/widgets/common/flag.dart';
import 'package:bratacha/widgets/game_screen/answers_cubit.dart';
import 'package:bratacha/widgets/game_screen/question_cubit.dart';
import 'package:bratacha/widgets/game_screen/score_cubit.dart';
import 'package:bratacha/widgets/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameScreenArguments {
  final int level;

  const GameScreenArguments({@required this.level});
}

class GameScreen extends StatelessWidget {
  static const routeName = 'GameScreen';

  const GameScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as GameScreenArguments;
    final level = args.level;

    return RepositoryProvider<IGameService>(
      create: (_) => GameService(
        isHardDifficulty: context.repository<IPlayerDataService>().isHardDifficulty,
        playerDataService: context.repository<IPlayerDataService>(),
        level: level,
        levelManager: context.repository<LevelManager>(),
      )..initialize(),
      lazy: false,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<QuestionCubit>(
            create: (contextRepository) => QuestionCubit(
              gameService: contextRepository.repository<IGameService>(),
            ),
          ),
          BlocProvider<AnswersCubit>(
            create: (contextRepository) => AnswersCubit(
              gameService: contextRepository.repository<IGameService>(),
            ),
          ),
          BlocProvider<ScoreCubit>(
            create: (contextRepository) => ScoreCubit(
              gameService: contextRepository.repository<IGameService>(),
            ),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pushReplacementNamed(HomeScreen.routeName),
            ),
            title: Text(AppLocalizations.generalLevelLabel(level: level + 1)),
            actions: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: BlocBuilder<ScoreCubit, int>(
                    builder: (_, score) => Text(
                      score.toString(),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Center(
              child: QuestionAnswerPanel(),
            ),
          ),
        ),
      ),
    );
  }
}

class QuestionAnswerPanel extends StatelessWidget {
  const QuestionAnswerPanel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.0),
        BlocBuilder<QuestionCubit, String>(
          builder: (_, question) => Expanded(
            child: Center(
              child: Text(
                question,
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        BlocBuilder<AnswersCubit, List<String>>(
          builder: (_, answers) => LayoutBuilder(
            builder: (_, constraints) {
              final size = (constraints.maxWidth - 16.0 - 16.0 - 16.0) / 2;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Wrap(
                  spacing: 16.0,
                  runSpacing: 16.0,
                  children: [
                    for (final id in answers)
                      GestureDetector(
                        child: Flag(
                          id,
                          width: size,
                          height: size,
                        ),
                        onTap: () {
                          final gameService = context.repository<IGameService>();
                          gameService.answerWithId(id);
                          if (gameService.levelCompleted) {
                            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                          }
                        },
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
