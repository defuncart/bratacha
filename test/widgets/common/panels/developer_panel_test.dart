import 'package:bratacha/widgets/common/panels/developer_panel.dart';
import 'package:bratacha/widgets/common/text/clickable_text.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../tester_utils.dart';

void main() {
  group('$DeveloperPanel', () {
    testWidgets('Ensure widget tree is correct', (tester) async {
      await tester.pumpWidget(
        wrapWithMaterialApp(const DeveloperPanel()),
      );

      expect(find.byType(ClickableText), findsOneWidget);
    });
  });
}
