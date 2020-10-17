import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/managers/level_manager.dart';
import 'package:bratacha/modules/dialog_manager/dialog_manager.dart';
import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:bratacha/services/game_service.dart';
import 'package:bratacha/services/i_game_service.dart';
import 'package:bratacha/widgets/common/score.dart';
import 'package:bratacha/widgets/game_screen/answers_cubit.dart';
import 'package:bratacha/widgets/game_screen/question_answer_panel.dart';
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
              onPressed: () async {
                final response = await context.repository<IDialogService>().requestConfirmDialog(ConfirmDialogRequest(
                      title: AppLocalizations.quitGameDialogTitle,
                      description: AppLocalizations.quitGameDialogDescription,
                      negativeButtonText: AppLocalizations.generalNo,
                      positiveButtonText: AppLocalizations.generalYes,
                    ));
                if (response == ConfirmDialogResponseType.positive) {
                  await Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                }
              },
            ),
            title: Text(AppLocalizations.generalLevelLabel(level: level + 1)),
            actions: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: BlocBuilder<ScoreCubit, int>(
                    builder: (_, score) => Score(
                      score: score,
                      color: Colors.white,
                      fontSize: 20.0,
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
