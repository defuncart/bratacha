import 'package:bratacha/widgets/common/panels/data_privacy_panel.dart';
import 'package:bratacha/widgets/common/text/clickable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_utils.dart';

void main() {
  group('$DataPrivacyPanel', () {
    testWidgets('Ensure widget tree is correct', (tester) async {
      await tester.pumpWidget(
        wrapWithMaterialApp(const DataPrivacyPanel()),
      );

      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(ClickableText), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
    });
  });
}
