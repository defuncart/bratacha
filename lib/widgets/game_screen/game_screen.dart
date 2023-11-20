import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/managers/level_manager.dart';
import 'package:bratacha/modules/dialog_manager/dialog_manager.dart';
import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:bratacha/services/game_service/game_service.dart';
import 'package:bratacha/services/game_service/i_game_service.dart';
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

  const GameScreenArguments({required this.level});
}

class GameScreen extends StatelessWidget {
  static const routeName = 'GameScreen';

  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as GameScreenArguments;
    final level = args.level;

    return RepositoryProvider<IGameService>(
      create: (_) => GameService(
        isHardDifficulty: context.read<IPlayerDataService>().isHardDifficulty,
        playerDataService: context.read<IPlayerDataService>(),
        level: level,
        levelManager: context.read<LevelManager>(),
      )..initialize(),
      lazy: false,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<QuestionCubit>(
            create: (contextRepository) => QuestionCubit(
              gameService: contextRepository.read<IGameService>(),
            ),
          ),
          BlocProvider<AnswersCubit>(
            create: (contextRepository) => AnswersCubit(
              gameService: contextRepository.read<IGameService>(),
            ),
          ),
          BlocProvider<ScoreCubit>(
            create: (contextRepository) => ScoreCubit(
              gameService: contextRepository.read<IGameService>(),
            ),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () async {
                final navigator = Navigator.of(context);
                final response = await context.read<IDialogService>().requestConfirmDialog(
                      ConfirmDialogRequest(
                        title: AppLocalizations.quitGameDialogTitle,
                        description: AppLocalizations.quitGameDialogDescription,
                        negativeButtonText: AppLocalizations.generalNo,
                        positiveButtonText: AppLocalizations.generalYes,
                      ),
                    );
                if (response.isPositive) {
                  await navigator.pushReplacementNamed(HomeScreen.routeName);
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
          body: const SafeArea(
            child: Center(
              child: QuestionAnswerPanel(),
            ),
          ),
        ),
      ),
    );
  }
}
