import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/widgets/common/panels/language_panel/language_cubit.dart';
import 'package:bratacha/widgets/common/panels/language_panel/language_panel.dart';
import 'package:bratacha/widgets/onboarding_screen/onboarding_page1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks.dart';
import '../../test_utils.dart';

void main() {
  group('$OnboardingPage1', () {
    testWidgets('Ensure widget tree is correct', (tester) async {
      final mockLanguageCubit = MockLanguageCubit();
      whenState(mockLanguageCubit, 'en');

      tester.setSize(const Size(600, 900));
      await tester.pumpWidget(
        BlocProvider<LanguageCubit>.value(
          value: mockLanguageCubit,
          child: wrapWithMaterialApp(
            const OnboardingPage1(),
          ),
        ),
      );

      expect(find.byType(Column), findsNWidgets(2));
      expect(find.byType(LanguagePanel), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(4));

      final context = tester.element(find.byType(OnboardingPage1));
      expect(find.text(context.l10n.onboardingPage1TextLabel1), findsOneWidget);
      expect(find.text(context.l10n.onboardingPage1TextLabel2), findsOneWidget);
      expect(find.text(context.l10n.onboardingPage1TextLabel3), findsOneWidget);
      expect(find.text(context.l10n.onboardingGeneralSettingLabel), findsOneWidget);
    });
  });
}
