import 'package:bratacha/extensions/test_window_extensions.dart';
import 'package:bratacha/intl/country_localizations.dart';
import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:bratacha/widgets/common/panels/hard_difficulty_panel/hard_difficulty_cubit.dart';
import 'package:bratacha/widgets/common/panels/hard_difficulty_panel/hard_difficulty_panel.dart';
import 'package:bratacha/widgets/game_screen/question_answer_panel.dart';
import 'package:bratacha/widgets/onboarding_screen/onboarding_page2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  // ensure localizations are setup
  AppLocalizations.load(Locale('en'));
  CountryLocalizations.load(Locale('en'));

  testWidgets('Ensure widget tree is correct', (tester) async {
    // set size to ensure portrait orientation
    tester.binding.window.simulateSize(Size(540, 1170));

    await tester.pumpWidget(
      BlocProvider<HardDifficultyCubit>(
        create: (_) => HardDifficultyCubit(_MockPlayerDataService()),
        child: MaterialApp(
          home: Scaffold(
            body: OnboardingPage2(),
          ),
        ),
      ),
    );

    expect(find.byType(HardDifficultyPanel), findsOneWidget);
    expect(find.byType(QuestionAnswerPanel), findsOneWidget);
    expect(find.byType(Text), findsNWidgets(5));
  });

  testWidgets('Ensure widget content is correct', (tester) async {
    // set size to ensure portrait orientation
    tester.binding.window.simulateSize(Size(540, 1170));

    await tester.pumpWidget(
      BlocProvider<HardDifficultyCubit>(
        create: (_) => HardDifficultyCubit(_MockPlayerDataService()),
        child: MaterialApp(
          home: Scaffold(
            body: OnboardingPage2(),
          ),
        ),
      ),
    );

    expect(find.text(AppLocalizations.onboardingPage2TextLabel1), findsOneWidget);
    expect(find.text(AppLocalizations.onboardingPage2TextLabel2), findsOneWidget);
    expect(find.text(AppLocalizations.onboardingGeneralSettingLabel), findsOneWidget);
  });
}

class _MockPlayerDataService extends Mock implements IPlayerDataService {
  @override
  bool get isHardDifficulty => false;
}
