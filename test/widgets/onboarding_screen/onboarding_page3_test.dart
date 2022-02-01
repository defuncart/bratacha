import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/widgets/common/panels/data_privacy_panel.dart';
import 'package:bratacha/widgets/common/panels/developer_panel.dart';
import 'package:bratacha/widgets/onboarding_screen/onboarding_page3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // ensure localizations are setup
  AppLocalizations.load(const Locale('en'));

  group('$OnboardingPage3', () {
    testWidgets('Ensure widget tree is correct', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: OnboardingPage3(),
        ),
      ));

      expect(find.byType(Column), findsNWidgets(2));
      expect(find.byType(DataPrivacyPanel), findsOneWidget);
      expect(find.byType(DeveloperPanel), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(4));
    });

    testWidgets('Ensure widget content is correct', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: OnboardingPage3(),
        ),
      ));

      expect(find.text(AppLocalizations.onboardingPage3TextLabel1), findsOneWidget);
      expect(find.text(AppLocalizations.onboardingPage3TextLabel2), findsOneWidget);
      expect(find.text(AppLocalizations.feedbackPanelLabel1), findsOneWidget);
    });
  });
}
