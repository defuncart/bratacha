import 'dart:async';

import 'package:bratacha/services/game_service/i_game_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class GameState {}

class GameStateStartRound extends GameState {
  final double progress;
  final String question;
  final List<String> answers;

  GameStateStartRound({
    required this.progress,
    required this.question,
    required this.answers,
  });
}

class GameStateEndRound extends GameState {
  final double progress;
  final String question;
  final List<String> answers;
  final String correctAnswer;
  final String userAnswer;
  final String userAnsweredLocalized;

  bool get answeredCorrectly => correctAnswer == userAnswer;

  GameStateEndRound({
    required this.progress,
    required this.question,
    required this.answers,
    required this.correctAnswer,
    required this.userAnswer,
    required this.userAnsweredLocalized,
  });
}

class GameStateEndGame extends GameState {
  final double levelProgressBefore;
  final double levelProgressAfter;
  final int numberRounds;
  final int correctAnswers;
  final List<String> incorrectIds;

  GameStateEndGame({
    required this.levelProgressBefore,
    required this.levelProgressAfter,
    required this.numberRounds,
    required this.correctAnswers,
    required this.incorrectIds,
  });
}

class GameCubit extends Cubit<GameState> {
  final IGameService _gameService;

  GameCubit({
    required IGameService gameService,
  })  : _gameService = gameService,
        super(GameStateStartRound(progress: 0, question: '', answers: []));

  GameRound? _gameRound;

  void initialize() => _nextRoundAndEmit();

  void answerWithId(String id) {
    final result = _gameService.answerWithId(id);
    final isCorrect = result.$1 == id;
    final isGameOver = result.$3 == 1;

    emit(GameStateEndRound(
      progress: result.$3,
      question: _gameRound!.question,
      answers: _gameRound!.answers,
      correctAnswer: result.$1,
      userAnswer: id,
      userAnsweredLocalized: result.$2,
    ));

    Timer.periodic(Duration(milliseconds: isCorrect ? 1000 : 2000), (timer) {
      timer.cancel();

      if (isGameOver) {
        emit(GameStateEndGame(
          levelProgressBefore: result.$4!.levelProgressBefore,
          levelProgressAfter: result.$4!.levelProgressAfter,
          numberRounds: result.$4!.numberRounds,
          correctAnswers: result.$4!.correctAnswers,
          incorrectIds: result.$4!.incorrectIds,
        ));
      } else {
        _nextRoundAndEmit();
      }
    });
  }

  void _nextRoundAndEmit() {
    _gameRound = _gameService.nextRound();
    emit(GameStateStartRound(
      progress: _gameRound!.progress,
      question: _gameRound!.question,
      answers: _gameRound!.answers,
    ));
  }
}
