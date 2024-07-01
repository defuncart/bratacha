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
        when(() => mockGameService.nextRound()).thenReturn((
          progress: 0,
          question: 'aLocalized',
          answers: ['a', 'b', 'c', 'd'],
          result: null,
        ));
      },
      build: () => GameCubit(gameService: mockGameService),
      act: (cubit) => cubit.initialize(),
      expect: () => [
        isA<GameState>(),
      ],
    );
  });
}
