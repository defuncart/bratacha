import 'package:bratacha/intl/country_localizations.dart';
import 'package:bratacha/widgets/common/flag.dart';
import 'package:bratacha/widgets/game_screen/game_cubit.dart';
import 'package:bratacha/widgets/game_screen/question_answer_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';
import '../../test_utils.dart';

void main() {
  // ensure localizations are setup
  CountryLocalizations.load(const Locale('en'));

  group('$QuestionAnswerPanel', () {
    late MockGameCubit mockGameCubit;

    setUp(() {
      mockGameCubit = MockGameCubit();
    });

    testWidgets('when $GameStateStartRound, ensure correct widget tree', (tester) async {
      // set size to ensure portrait orientation
      tester.binding.window.physicalSizeTestValue = const Size(540, 1170);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      final state = GameStateStartRound(
        progress: 0,
        question: 'Germany',
        answers: ['de', 'ie', 'pl', 'fr'],
      );
      whenState(mockGameCubit, state);

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<GameCubit>.value(
              value: mockGameCubit,
            ),
          ],
          child: const MaterialApp(
            home: QuestionAnswerPanel(),
          ),
        ),
      );

      expect(find.byType(QuestionAnswerPanel), findsOneWidget);
      expect(find.byType(QuestionAnswerPanelContent), findsOneWidget);
      expect(find.text('Germany'), findsOneWidget);
      expect(find.byType(GestureDetector), findsNWidgets(4));
      expect(find.byType(Flag), findsNWidgets(4));
      expect(find.byType(SvgPicture), findsNWidgets(4));

      await tester.tap(find.byType(GestureDetector).first);
      verify(() => mockGameCubit.answerWithId(any())).called(1);
    });

    group('when $GameStateEndRound', () {
      testWidgets('and user answered correctly, expect correct widget tree', (tester) async {
        // set size to ensure portrait orientation
        tester.binding.window.physicalSizeTestValue = const Size(540, 1170);
        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

        final state = GameStateEndRound(
          progress: 0,
          question: 'Germany',
          answers: ['de', 'ie', 'pl', 'fr'],
          correctAnswer: 'de',
          userAnswer: 'de',
          userAnsweredLocalized: 'Germany',
        );
        whenState(mockGameCubit, state);

        await tester.pumpWidget(
          MultiBlocProvider(
            providers: [
              BlocProvider<GameCubit>.value(
                value: mockGameCubit,
              ),
            ],
            child: const MaterialApp(
              home: QuestionAnswerPanel(),
            ),
          ),
        );

        expect(find.byType(QuestionAnswerPanel), findsOneWidget);
        expect(find.byType(QuestionAnswerPanelContent), findsOneWidget);
        expect(find.text('Germany'), findsOneWidget);
        expect(find.byType(GestureDetector), findsNothing);
        expect(find.byType(Flag), findsNWidgets(4));
        expect(find.byType(SvgPicture), findsNWidgets(4));
        expect(find.byIcon(Icons.check), findsOneWidget);
        expect(find.byIcon(Icons.close), findsNothing);
        expect(
          tester.widgetList(find.byType(Opacity)).whereType<Opacity>().where((opacity) => opacity.opacity != 1),
          hasLength(3),
        );
      });

      testWidgets('and user answered incorrectly, expect correct widget tree', (tester) async {
        // set size to ensure portrait orientation
        tester.binding.window.physicalSizeTestValue = const Size(540, 1170);
        addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

        final state = GameStateEndRound(
          progress: 0,
          question: 'Germany',
          answers: ['de', 'ie', 'pl', 'fr'],
          correctAnswer: 'de',
          userAnswer: 'pl',
          userAnsweredLocalized: 'Poland',
        );
        whenState(mockGameCubit, state);

        await tester.pumpWidget(
          MultiBlocProvider(
            providers: [
              BlocProvider<GameCubit>.value(
                value: mockGameCubit,
              ),
            ],
            child: const MaterialApp(
              home: QuestionAnswerPanel(),
            ),
          ),
        );

        expect(find.byType(QuestionAnswerPanel), findsOneWidget);
        expect(find.byType(QuestionAnswerPanelContent), findsOneWidget);
        expect(find.text('Germany'), findsOneWidget);
        expect(find.byType(GestureDetector), findsNothing);
        expect(find.byType(Flag), findsNWidgets(4));
        expect(find.byType(SvgPicture), findsNWidgets(4));
        expect(find.byIcon(Icons.check), findsNothing);
        expect(find.byIcon(Icons.close), findsOneWidget);
        expect(find.text('Poland'), findsOneWidget);
        expect(
          tester.widgetList(find.byType(Opacity)).whereType<Opacity>().where((opacity) => opacity.opacity != 1),
          hasLength(3),
        );
      });
    });

    testWidgets('when $GameStateEndGame, ensure correct widget tree', (tester) async {
      // set size to ensure portrait orientation
      tester.binding.window.physicalSizeTestValue = const Size(540, 1170);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      final state = GameStateEndGame(
        correctPercentage: 1,
        canPlayNextLevel: true,
        nextLevelUnlocked: true,
        incorrectIds: [],
      );
      whenState(mockGameCubit, state);

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<GameCubit>.value(
              value: mockGameCubit,
            ),
          ],
          child: const MaterialApp(
            home: QuestionAnswerPanel(),
          ),
        ),
      );

      expect(find.byType(QuestionAnswerPanel), findsOneWidget);
      expect(find.byType(QuestionAnswerPanelContent), findsNothing);
    });
  });
}
