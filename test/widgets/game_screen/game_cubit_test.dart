import 'package:bloc_test/bloc_test.dart';
import 'package:bratacha/widgets/game_screen/game_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  group('$GameCubit', () {
    late MockGameService mockGameService;

    setUp(() {
      mockGameService = MockGameService();
    });

    blocTest<GameCubit, GameState>(
      'when IGameService returns next round, emits correct state',
      setUp: () {
        when(() => mockGameService.nextRound()).thenReturn((question: 'aLocalized', answers: ['a', 'b', 'c', 'd']));
        // when(() => mockGameService.answerWithId(any())).thenReturn(true);
        // when(() => mockGameService.levelCompleted).thenReturn(false);
      },
      build: () => GameCubit(gameService: mockGameService),
      act: (cubit) => cubit.initialize(),
      expect: () => [
        isA<GameState>(),
      ],
    );
  });
}

// class _MockGameService extends Mock implements IGameService {
//   final List<List<String>> _answers;

//   _MockGameService({required List<List<String>> answers}) : _answers = answers;

//   @override
//   GameRound nextRound() => (
//         question: '',
//         answers: _answers,
//       );
// }
