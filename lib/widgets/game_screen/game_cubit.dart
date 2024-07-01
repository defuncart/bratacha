import 'dart:async';

import 'package:bratacha/services/game_service/i_game_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class GameState {}

class GameStateStartRound extends GameState {
  final String question;
  final List<String> answers;

  GameStateStartRound({
    required this.question,
    required this.answers,
  });
}

class GameStateEndRound extends GameState {
  final String question;
  final List<String> answers;
  final String correctAnswer;
  final String userAnswer;
  final String userAnsweredLocalized;

  bool get answeredCorrectly => correctAnswer == userAnswer;

  GameStateEndRound({
    required this.question,
    required this.answers,
    required this.correctAnswer,
    required this.userAnswer,
    required this.userAnsweredLocalized,
  });
}

class GameStateEndGame extends GameState {
  final String question;
  final List<String> answers;
  final bool answeredCorrectly;

  GameStateEndGame({
    required this.question,
    required this.answers,
    required this.answeredCorrectly,
  });
}

class GameCubit extends Cubit<GameState> {
  final IGameService _gameService;

  GameCubit({
    required IGameService gameService,
  })  : _gameService = gameService,
        super(GameStateStartRound(question: '', answers: []));

  GameRound? _gameRound;

  void initialize() => _nextRoundAndEmit();

  void answerWithId(String id) {
    final result = _gameService.answerWithId(id);
    final isCorrect = result.$1 == id;

    emit(GameStateEndRound(
      question: _gameRound!.question,
      answers: _gameRound!.answers,
      correctAnswer: result.$1,
      userAnswer: id,
      userAnsweredLocalized: result.$2,
    ));

    Timer.periodic(Duration(milliseconds: isCorrect ? 1000 : 2000), (timer) {
      timer.cancel();

      if (_gameService.levelCompleted) {
        emit(GameStateEndGame(
          question: _gameRound!.question,
          answers: _gameRound!.answers,
          answeredCorrectly: false,
        ));
      } else {
        _nextRoundAndEmit();
      }
    });
  }

  void _nextRoundAndEmit() {
    _gameRound = _gameService.nextRound();
    emit(GameStateStartRound(
      question: _gameRound!.question,
      answers: _gameRound!.answers,
    ));
  }
}
