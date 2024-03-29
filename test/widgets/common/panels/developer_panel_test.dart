import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/widgets/common/panels/developer_panel.dart';
import 'package:bratacha/widgets/common/text/clickable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // ensure localizations are setup
  AppLocalizations.load(const Locale('en'));

  group('$DeveloperPanel', () {
    testWidgets('Ensure widget tree is correct', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: DeveloperPanel()),
      );

      expect(find.byType(ClickableText), findsOneWidget);
    });
  });
}
