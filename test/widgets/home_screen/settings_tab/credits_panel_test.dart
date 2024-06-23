import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/widgets/common/panels/developer_panel.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/credits_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../tester_utils.dart';

void main() {
  group('$CreditsPanel', () {
    testWidgets('Ensure widget tree is correct', (tester) async {
      await tester.pumpWidget(
        wrapWithMaterialApp(const CreditsPanel()),
      );

      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(find.byType(SizedBox), findsOneWidget);
      expect(find.byType(DeveloperPanel), findsOneWidget);
    });

    testWidgets('Ensure content is correct', (tester) async {
      await tester.pumpWidget(
        wrapWithMaterialApp(const CreditsPanel()),
      );

      final context = tester.element(find.byType(CreditsPanel));
      expect(find.text(context.l10n.creditsDialogDescriptionLabel1), findsOneWidget);
    });
  });
}
