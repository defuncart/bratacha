import 'package:bratacha/widgets/home_screen/settings_tab/feedback_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../test_utils.dart';

void main() {
  group('$FeedbackPanel', () {
    late MockUrlLauncherService mockUrlLauncherService;

    setUp(() {
      mockUrlLauncherService = MockUrlLauncherService();
      when(() => mockUrlLauncherService.openUrl(any())).thenAnswer((_) async {});
    });

    testWidgets('Ensure widget tree is correct', (tester) async {
      await tester.pumpWidget(
        wrapWithMaterialApp(
          FeedbackPanel(
            urlLaucherService: mockUrlLauncherService,
          ),
        ),
      );

      expect(find.byType(FeedbackPanel), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(5));
      expect(find.byType(TextButton), findsNWidgets(2));
    });

    testWidgets('Ensure translations button is clickable', (tester) async {
      await tester.pumpWidget(
        wrapWithMaterialApp(
          FeedbackPanel(
            urlLaucherService: mockUrlLauncherService,
          ),
        ),
      );

      final button = find.byType(TextButton).at(0);

      await tester.tap(button);

      verify(() => mockUrlLauncherService.openUrl(any()));
    });

    testWidgets('Ensure feedback button is clickable', (tester) async {
      await tester.pumpWidget(
        wrapWithMaterialApp(
          FeedbackPanel(
            urlLaucherService: mockUrlLauncherService,
          ),
        ),
      );

      final button = find.byType(TextButton).at(1);

      await tester.tap(button);

      verify(() => mockUrlLauncherService.openUrl(any()));
    });
  });
}
