import 'package:bratacha/extensions/test_window_extensions.dart';
import 'package:bratacha/intl/country_localizations.dart';
import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/widgets/common/panels/hard_mode_panel/hard_mode_cubit.dart';
import 'package:bratacha/widgets/common/panels/hard_mode_panel/hard_mode_panel.dart';
import 'package:bratacha/widgets/game_screen/question_answer_panel.dart';
import 'package:bratacha/widgets/onboarding_screen/onboarding_page2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';
import '../../test_utils.dart';

void main() {
  CountryLocalizations.load(const Locale('en'));

  group('$OnboardingPage2', () {
    testWidgets('Ensure widget tree is correct', (tester) async {
      final mockHardModeCubit = MockHardModeCubit();
      whenState(mockHardModeCubit, false);

      // set size to ensure portrait orientation
      tester.binding.window.simulateSize(const Size(540, 1170));

      await tester.pumpWidget(
        BlocProvider<HardModeCubit>.value(
          value: mockHardModeCubit,
          child: wrapWithMaterialApp(
            const Scaffold(
              body: OnboardingPage2(),
            ),
          ),
        ),
      );

      expect(find.byType(HardModePanel), findsOneWidget);
      expect(find.byType(QuestionAnswerPanel), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(4));

      final context = tester.element(find.byType(OnboardingPage2));
      expect(find.text(context.l10n.onboardingPage2TextLabel1), findsOneWidget);
      expect(find.text(context.l10n.onboardingGeneralSettingLabel), findsOneWidget);
    });
  });
}
