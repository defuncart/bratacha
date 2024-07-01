import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/managers/level_manager.dart';
import 'package:bratacha/modules/dialog_manager/dialog_manager.dart';
import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:bratacha/services/game_service/game_service.dart';
import 'package:bratacha/services/game_service/i_game_service.dart';
import 'package:bratacha/widgets/game_screen/game_cubit.dart';
import 'package:bratacha/widgets/game_screen/question_answer_panel.dart';
import 'package:bratacha/widgets/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameScreenArguments {
  final int level;

  const GameScreenArguments({required this.level});
}

class GameScreen extends StatelessWidget {
  static const routeName = 'GameScreen';

  const GameScreen({super.key});

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
      ),
      lazy: false,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<GameCubit>(
            create: (contextRepository) => GameCubit(
              gameService: contextRepository.read<IGameService>(),
            )..initialize(),
          ),
        ],
        // TODO add bloc listener to navigate when game over
        // Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () async {
                final navigator = Navigator.of(context);
                final response = await context.read<IDialogService>().requestConfirmDialog(
                      ConfirmDialogRequest(
                        title: context.l10n.quitGameDialogTitle,
                        description: context.l10n.quitGameDialogDescription,
                        negativeButtonText: context.l10n.generalNo,
                        positiveButtonText: context.l10n.generalYes,
                      ),
                    );
                if (response.isPositive) {
                  await navigator.pushReplacementNamed(HomeScreen.routeName);
                }
              },
            ),
            title: Text(context.l10n.generalLevelLabel(level + 1)),
            bottom: const _ProgressBar(),
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

class _ProgressBar extends StatelessWidget implements PreferredSizeWidget {
  const _ProgressBar();

  static const _size = Size(double.infinity, 4);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<GameCubit>().state;
    final progress = switch (state) {
      GameStateStartRound(:final progress) => progress,
      GameStateEndRound(:final progress) => progress,
      _ => 1.0,
    };

    return SizedBox.fromSize(
      size: _size,
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        tween: Tween<double>(
          begin: 0,
          end: progress,
        ),
        builder: (context, value, _) => LinearProgressIndicator(
          // minHeight: _size.height,
          backgroundColor: Colors.transparent,
          color: Theme.of(context).colorScheme.secondary,
          value: value,
        ),
      ),
    );

    // return SizedBox.fromSize(
    //   size: _size,
    //   child: ColoredBox(
    //     color: Theme.of(context).colorScheme.secondary,
    //   ),
    // );
  }

  @override
  Size get preferredSize => _size;
}
