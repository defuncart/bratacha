import 'package:bratacha/widgets/common/text/clickable_text_span.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$ClickableTextSpan', () {
    test('style null value does not trigger assertion', () {
      expect(
        () => ClickableTextSpan(
          text: '',
          url: '',
          style: null,
        ),
        returnsNormally,
      );
    });

    testWidgets('Ensure span is clickable', (tester) async {
      final widget = RichText(
        text: ClickableTextSpan(text: 'Link', url: 'https://bla.bla'),
      );

      await tester.pumpWidget(MaterialApp(home: widget));

      await tester.tap(find.byType(RichText));
    });
  });
}
