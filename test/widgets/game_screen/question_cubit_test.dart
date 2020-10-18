import 'package:bloc_test/bloc_test.dart';
import 'package:bratacha/services/game_service/i_game_service.dart';
import 'package:bratacha/widgets/game_screen/question_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('QuestionCubit', () {
    blocTest(
      'emits [] when nothing is added',
      build: () => QuestionCubit(gameService: _MockGameService(questions: [])),
      expect: [],
    );

    blocTest(
      'emits [a] when IGameService emits question a',
      build: () => QuestionCubit(gameService: _MockGameService(questions: ['a'])),
      expect: ['a'],
    );

    blocTest(
      'emits [a, b] when IGameService emits questions a and b',
      build: () => QuestionCubit(gameService: _MockGameService(questions: ['a', 'b'])),
      expect: ['a', 'b'],
    );
  });
}

class _MockGameService extends Mock implements IGameService {
  final List<String> _questions;

  _MockGameService({@required List<String> questions}) : _questions = questions;

  @override
  Stream<String> get questionCountry async* {
    for (final question in _questions) {
      yield question;
    }
  }
}
