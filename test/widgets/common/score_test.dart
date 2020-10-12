import 'package:bratacha/widgets/common/score.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Ensure widget tree is correct', (tester) async {
    final scoreWidget = Score(
      score: 0,
      color: Colors.white,
    );

    await tester.pumpWidget(MaterialApp(home: scoreWidget));

    expect(find.byType(Text), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
    expect(find.byType(Icon), findsOneWidget);
  });

  testWidgets('Ensure correct styling', (tester) async {
    final color = Colors.white;
    final fontSize = 16.0;
    final scoreWidget = Score(
      score: 0,
      color: color,
      fontSize: fontSize,
    );

    await tester.pumpWidget(MaterialApp(home: scoreWidget));

    final textWidget = tester.firstWidget(find.byType(Text)) as Text;
    final iconWidget = tester.firstWidget(find.byType(Icon)) as Icon;

    expect(textWidget.style.color, color);
    expect(iconWidget.color, color);

    expect(textWidget.style.fontSize, fontSize);
    expect(iconWidget.size, fontSize * 1.5);
  });
}
