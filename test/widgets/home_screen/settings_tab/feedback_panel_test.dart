import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/services/url_launcher_service/i_url_launcher_service.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/feedback_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  // ensure localizations are setup
  AppLocalizations.load(Locale('en'));

  group('$FeedbackPanel', () {
    late IUrlLaucherService mockUrlLauncherService;

    setUp(() {
      mockUrlLauncherService = _MockUrlLauncherService();
      when(() => mockUrlLauncherService.openUrl(any())).thenAnswer((_) async {});
    });

    testWidgets('Ensure widget tree is correct', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FeedbackPanel(
            urlLaucherService: mockUrlLauncherService,
          ),
        ),
      );

      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(2));
      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('Ensure content is correct', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FeedbackPanel(
            urlLaucherService: mockUrlLauncherService,
          ),
        ),
      );

      expect(find.text(AppLocalizations.feedbackPanelLabel1), findsOneWidget);
      expect(find.text(AppLocalizations.feedbackPanelGiveFeedbackButtonText), findsOneWidget);
    });

    testWidgets('Ensure feedback button is clickable', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FeedbackPanel(
            urlLaucherService: mockUrlLauncherService,
          ),
        ),
      );

      final button = find.byType(TextButton);

      await tester.tap(button);

      verify(() => mockUrlLauncherService.openUrl(any()));
    });
  });
}

class _MockUrlLauncherService extends Mock implements IUrlLaucherService {}
