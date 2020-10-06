import 'dart:async';

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

class GameScreen extends StatefulWidget {
  static const routeName = 'GameScreen';

  const GameScreen({Key key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  var _isLoading = true;
  GameService _gameService;

  @override
  void initState() {
    super.initState();

    scheduleMicrotask(() {
      final args = ModalRoute.of(context).settings.arguments as GameScreenArguments;
      final level = args.level;
      _gameService = GameService(
        isHardDifficulty: context.repository<ISettingsDatabase>().isHardDifficulty,
        level: level,
        levelManager: context.repository<LevelManager>(),
      );
      _gameService.initialize();
      setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _isLoading
          ? Container()
          : RepositoryProvider<IGameService>(
              create: (_) => _gameService,
              child: MultiBlocProvider(
                providers: [
                  BlocProvider<QuestionCubit>(
                    create: (_) => QuestionCubit(gameService: _.repository<IGameService>()),
                  ),
                  BlocProvider<AnswersCubit>(
                    create: (_) => AnswersCubit(gameService: _.repository<IGameService>()),
                  ),
                ],
                child: Builder(
                  builder: (_) => SafeArea(
                    child: Center(
                      child: QuestionAnswerPanel(),
                    ),
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
