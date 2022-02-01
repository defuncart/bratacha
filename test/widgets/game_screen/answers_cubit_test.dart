import 'package:bloc_test/bloc_test.dart';
import 'package:bratacha/services/game_service/i_game_service.dart';
import 'package:bratacha/widgets/game_screen/answers_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('$AnswersCubit', () {
    blocTest<AnswersCubit, List<String>>(
      'emits [] when nothing is added',
      build: () => AnswersCubit(gameService: _MockGameService(answers: [])),
      expect: () => [],
    );

    blocTest<AnswersCubit, List<String>>(
      'emits [[a, b, c, d]] when IGameService emits answers [a, b, c, d]',
      build: () => AnswersCubit(
          gameService: _MockGameService(
        answers: [
          ['a', 'b', 'c', 'd'],
        ],
      )),
      expect: () => [
        ['a', 'b', 'c', 'd']
      ],
    );

    blocTest<AnswersCubit, List<String>>(
      'emits [[a, b, c, d], [e, f, g, h]] when IGameService emits answers [a, b, c, d] and [e, f, g, h]',
      build: () => AnswersCubit(
          gameService: _MockGameService(
        answers: [
          ['a', 'b', 'c', 'd'],
          ['e', 'f', 'g', 'h'],
        ],
      )),
      expect: () => [
        ['a', 'b', 'c', 'd'],
        ['e', 'f', 'g', 'h'],
      ],
    );
  });
}

class _MockGameService extends Mock implements IGameService {
  final List<List<String>> _answers;

  _MockGameService({required List<List<String>> answers}) : _answers = answers;

  @override
  Stream<List<String>> get answerCountries async* {
    for (final answer in _answers) {
      yield answer;
    }
  }
}
