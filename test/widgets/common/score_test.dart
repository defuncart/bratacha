import 'package:bratacha/widgets/common/score.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$Score', () {
    testWidgets('Ensure widget tree is correct', (tester) async {
      const scoreWidget = Score(
        score: 0,
        color: Colors.white,
      );

      await tester.pumpWidget(const MaterialApp(home: scoreWidget));

      expect(find.byType(Row), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(find.text('0'), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
    });

    testWidgets('Ensure correct styling', (tester) async {
      const color = Colors.white;
      const fontSize = 16.0;
      const scoreWidget = Score(
        score: 0,
        color: color,
        fontSize: fontSize,
      );

      await tester.pumpWidget(const MaterialApp(home: scoreWidget));

      final textWidget = tester.widget<Text>(find.byType(Text));
      final iconWidget = tester.widget<Icon>(find.byType(Icon));

      expect(textWidget.style?.color, color);
      expect(iconWidget.color, color);

      expect(textWidget.style?.fontSize, fontSize);
      expect(iconWidget.size, fontSize * 1.5);
    });

    test('score < 0 triggers assertion', () {
      expect(
        () => Score(
          score: -1,
          color: Colors.black,
        ),
        throwsAssertionError,
      );
    });

    test('fontSize < 8 triggers assertion', () {
      expect(
        () => Score(
          score: 1,
          color: Colors.white,
          fontSize: 6,
        ),
        throwsAssertionError,
      );
    });
  });
}
