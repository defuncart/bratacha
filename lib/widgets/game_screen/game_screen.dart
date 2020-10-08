import 'package:bratacha/managers/level_manager.dart';
import 'package:bratacha/modules/settings_database/settings_database.dart';
import 'package:bratacha/services/game_service.dart';
import 'package:bratacha/services/i_game_service.dart';
import 'package:bratacha/widgets/common/flag.dart';
import 'package:bratacha/widgets/game_screen/answers_cubit.dart';
import 'package:bratacha/widgets/game_screen/question_cubit.dart';
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

    return Scaffold(
      appBar: AppBar(),
      body: RepositoryProvider<IGameService>(
        create: (_) => GameService(
          isHardDifficulty: context.repository<ISettingsDatabase>().isHardDifficulty,
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
          ],
          child: SafeArea(
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
                            Navigator.of(context).pop();
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