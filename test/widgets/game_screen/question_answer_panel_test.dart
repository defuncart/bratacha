import 'package:bloc_test/bloc_test.dart';
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

void main() {
  // ensure localizations are setup
  CountryLocalizations.load(const Locale('en'));

  group('$QuestionAnswerPanel', () {
    late MockGameCubit mockGameCubit;

    setUp(() {
      mockGameCubit = MockGameCubit();

      final state = GameStateStartRound(
        progress: 0,
        question: 'Germany',
        answers: ['de', 'ie', 'pl', 'fr'],
      );
      when(() => mockGameCubit.state).thenReturn(state);
      whenListen(mockGameCubit, Stream.value(state));
    });

    testWidgets('Ensure widget tree is correct', (tester) async {
      // set size to ensure portrait orientation
      tester.binding.window.physicalSizeTestValue = const Size(540, 1170);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

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

      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(find.byType(Wrap), findsOneWidget);
      expect(find.byType(GestureDetector), findsNWidgets(4));
      expect(find.byType(Flag), findsNWidgets(4));
      expect(find.byType(SvgPicture), findsNWidgets(4));
    });

    testWidgets('Ensure questions can be answered', (tester) async {
      // set size to ensure portrait orientation
      tester.binding.window.physicalSizeTestValue = const Size(540, 1170);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

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
      await tester.pumpAndSettle();

      await tester.tap(find.byType(GestureDetector).first);
    });
  });
}
