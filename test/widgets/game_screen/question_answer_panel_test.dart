import 'package:bratacha/intl/country_localizations.dart';
import 'package:bratacha/services/game_service/i_game_service.dart';
import 'package:bratacha/widgets/game_screen/answers_cubit.dart';
import 'package:bratacha/widgets/game_screen/question_answer_panel.dart';
import 'package:bratacha/widgets/game_screen/question_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  // ensure localizations are setup
  CountryLocalizations.load(Locale('en'));

  group('$QuestionAnswerPanel', () {
    testWidgets('Ensure widget tree is correct', (tester) async {
      // set size to ensure portrait orientation
      tester.binding.window.physicalSizeTestValue = Size(540, 1170);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      final gameService = _MockGameService();
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<QuestionCubit>(
              create: (_) => QuestionCubit(gameService: gameService),
            ),
            BlocProvider<AnswersCubit>(
              create: (_) => AnswersCubit(gameService: gameService),
            ),
          ],
          child: MaterialApp(
            home: QuestionAnswerPanel(),
          ),
        ),
      );

      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(find.byType(SizedBox), findsOneWidget);
      expect(find.byType(Wrap), findsOneWidget);
      // expect(find.byType(Flag), findsNWidgets(4));
      // expect(find.byType(SvgPicture), findsNWidgets(4));
    });

    testWidgets('Ensure widget content is correct', (tester) async {
      // set size to ensure portrait orientation
      tester.binding.window.physicalSizeTestValue = Size(540, 1170);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      final gameService = _MockGameService();
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<QuestionCubit>(
              create: (_) => QuestionCubit(gameService: gameService),
            ),
            BlocProvider<AnswersCubit>(
              create: (_) => AnswersCubit(gameService: gameService),
            ),
          ],
          child: MaterialApp(
            home: QuestionAnswerPanel(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text(gameService._question), findsOneWidget);
      expect(find.byType(GestureDetector), findsNWidgets(4));
    });

    testWidgets('Ensure questions can be answered', (tester) async {
      // set size to ensure portrait orientation
      tester.binding.window.physicalSizeTestValue = Size(540, 1170);
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      final gameService = _MockGameService();
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<QuestionCubit>(
              create: (_) => QuestionCubit(gameService: gameService),
            ),
            BlocProvider<AnswersCubit>(
              create: (_) => AnswersCubit(gameService: gameService),
            ),
          ],
          child: RepositoryProvider<IGameService>(
            create: (_) => gameService,
            child: MaterialApp(
              home: QuestionAnswerPanel(),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.byType(GestureDetector).first);
    });
  });
}

class _MockGameService extends Mock implements IGameService {
  final _question = 'Germany';
  final _answersEasy = ['de', 'ie', 'pl', 'fr'];

  _MockGameService();

  @override
  Stream<List<String>> get answerCountries async* {
    yield _answersEasy;
  }

  @override
  Stream<String> get questionCountry async* {
    yield _question;
  }

  @override
  bool get levelCompleted => false;

  @override
  bool answerWithId(String id) => false;
}
