import 'package:bloc_test/bloc_test.dart';
import 'package:bratacha/services/game_service/i_game_service.dart';
import 'package:bratacha/widgets/game_screen/score_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('ScoreCubit', () {
    blocTest(
      'emits [] when nothing is added',
      build: () => ScoreCubit(gameService: _MockGameService(scores: [])),
      expect: [],
    );

    blocTest(
      'emits [0] when IGameService emits score 0',
      build: () => ScoreCubit(gameService: _MockGameService(scores: [0])),
      expect: [0],
    );

    blocTest(
      'emits [0, 1] when IGameService emits scores 0 and 1',
      build: () => ScoreCubit(gameService: _MockGameService(scores: [0, 1])),
      expect: [0, 1],
    );
  });
}

class _MockGameService extends Mock implements IGameService {
  final List<int> _scores;

  _MockGameService({@required List<int> scores}) : _scores = scores;

  @override
  Stream<int> get currentScore async* {
    for (final score in _scores) {
      yield score;
    }
  }
}
