import 'package:bratacha/services/game_service/i_game_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef GameState = ({
  String question,
  List<String> answers,
});

class GameCubit extends Cubit<GameState> {
  final IGameService _gameService;

  GameCubit({
    required IGameService gameService,
  })  : _gameService = gameService,
        super((question: '', answers: []));

  void initialize() => _nextRoundAndEmit();

  void answerWithId(String id) {
    _gameService.answerWithId(id);

    if (_gameService.levelCompleted) {
      // emit gameover state
    } else {
      _nextRoundAndEmit();
    }
  }

  void _nextRoundAndEmit() {
    final gameRound = _gameService.nextRound();
    emit((
      question: gameRound.question,
      answers: gameRound.answers,
    ));
  }
}
