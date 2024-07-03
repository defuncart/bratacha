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

    group('when IGameService returns next round', () {
      setUp(() {
        when(() => mockGameService.nextRound()).thenReturn((
          progress: 0,
          question: 'aLocalized',
          answers: ['a', 'b', 'c', 'd'],
          result: null,
        ));
      });

      blocTest<GameCubit, GameState>(
        'expect correct state is emitted',
        build: () => GameCubit(gameService: mockGameService),
        act: (cubit) => cubit.initialize(),
        expect: () => [
          // GameStateStartRound(
          //   progress: 0,
          //   question: 'aLocalized',
          //   answers: ['a', 'b', 'c', 'd'],
          // ),
          isA<GameStateStartRound>()
              .having((state) => state.progress, 'progress', 0)
              .having((state) => state.question, 'question', 'aLocalized')
              .having((state) => state.answers, 'answers', ['a', 'b', 'c', 'd']),
        ],
      );

      blocTest<GameCubit, GameState>(
        'and user answers and game is not complete, expect correct state is emitted',
        setUp: () {
          when(() => mockGameService.answerWithId(any())).thenReturn((
            'a',
            'aLocalized',
            0.5,
            null,
          ));
        },
        build: () => GameCubit(gameService: mockGameService),
        act: (cubit) async {
          cubit.initialize();
          cubit.answerWithId('a');

          when(() => mockGameService.nextRound()).thenReturn((
            progress: 0.5,
            question: 'aLocalized',
            answers: ['a', 'b', 'c', 'd'],
            result: null,
          ));
          await Future.delayed(const Duration(seconds: 1));
        },
        expect: () => [
          // GameStateStartRound(
          //   progress: 0,
          //   question: 'aLocalized',
          //   answers: ['a', 'b', 'c', 'd'],
          // ),
          isA<GameStateStartRound>()
              .having((state) => state.progress, 'progress', 0)
              .having((state) => state.question, 'question', 'aLocalized')
              .having((state) => state.answers, 'answers', ['a', 'b', 'c', 'd']),
          // GameStateEndRound(
          //   progress: 0.5,
          //   question: 'aLocalized',
          //   answers: ['a', 'b', 'c', 'd'],
          //   correctAnswer: 'a',
          //   userAnswer: 'a',
          //   userAnsweredLocalized: 'aLocalized',
          // ),
          isA<GameStateEndRound>()
              .having((state) => state.progress, 'progress', 0.5)
              .having((state) => state.question, 'question', 'aLocalized')
              .having((state) => state.answers, 'answers', ['a', 'b', 'c', 'd'])
              .having((state) => state.correctAnswer, 'correctAnswer', 'a')
              .having((state) => state.userAnswer, 'userAnswer', 'a')
              .having((state) => state.userAnsweredLocalized, 'userAnsweredLocalized', 'aLocalized'),
          // GameStateStartRound(
          //   progress: 0.5,
          //   question: 'aLocalized',
          //   answers: ['a', 'b', 'c', 'd'],
          // ),
          isA<GameStateStartRound>()
              .having((state) => state.progress, 'progress', 0.5)
              .having((state) => state.question, 'question', 'aLocalized')
              .having((state) => state.answers, 'answers', ['a', 'b', 'c', 'd']),
        ],
      );

      blocTest<GameCubit, GameState>(
        'and user answers and game is complete, expect correct state is emitted',
        setUp: () {
          when(() => mockGameService.answerWithId(any())).thenReturn((
            'a',
            'aLocalized',
            1,
            (
              canPlayNextLevel: true,
              correctPercentage: 1,
              incorrectIds: [],
              nextLevelUnlocked: false,
            )
          ));
        },
        build: () => GameCubit(gameService: mockGameService),
        act: (cubit) async {
          cubit.initialize();
          cubit.answerWithId('a');

          await Future.delayed(const Duration(seconds: 1));
        },
        expect: () => [
          // GameStateStartRound(
          //   progress: 0,
          //   question: 'aLocalized',
          //   answers: ['a', 'b', 'c', 'd'],
          // ),
          isA<GameStateStartRound>()
              .having((state) => state.progress, 'progress', 0)
              .having((state) => state.question, 'question', 'aLocalized')
              .having((state) => state.answers, 'answers', ['a', 'b', 'c', 'd']),
          // GameStateEndRound(
          //   progress:1,
          //   question: 'aLocalized',
          //   answers: ['a', 'b', 'c', 'd'],
          //   correctAnswer: 'a',
          //   userAnswer: 'a',
          //   userAnsweredLocalized: 'aLocalized',
          // ),
          isA<GameStateEndRound>()
              .having((state) => state.progress, 'progress', 1)
              .having((state) => state.question, 'question', 'aLocalized')
              .having((state) => state.answers, 'answers', ['a', 'b', 'c', 'd'])
              .having((state) => state.correctAnswer, 'correctAnswer', 'a')
              .having((state) => state.userAnswer, 'userAnswer', 'a')
              .having((state) => state.userAnsweredLocalized, 'userAnsweredLocalized', 'aLocalized'),
          // GameStateEndGame(
          //   correctPercentage: 1,
          //   canPlayNextLevel: true,
          //   nextLevelUnlocked: false,
          //   incorrectIds: [],
          // ),
          isA<GameStateEndGame>()
              .having((state) => state.correctPercentage, 'correctPercentage', 1)
              .having((state) => state.canPlayNextLevel, 'canPlayNextLevel', isTrue)
              .having((state) => state.nextLevelUnlocked, 'nextLevelUnlocked', isFalse)
              .having((state) => state.incorrectIds, 'incorrectIds', isEmpty),
        ],
      );
    });
  });
}
