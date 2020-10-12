import 'package:bratacha/widgets/common/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Ensure widget tree is correct', (tester) async {
    final flagWidget = Flag(
      'de',
      width: 100,
      height: 100,
    );

    await tester.pumpWidget(MaterialApp(home: flagWidget));

    expect(find.byType(Flag), findsOneWidget);
    expect(find.byType(SvgPicture), findsOneWidget);
  });

  testWidgets('Ensure widget properties are correct', (tester) async {
    final flagWidget = Flag(
      'de',
      width: 100,
      height: 100,
    );

    await tester.pumpWidget(MaterialApp(home: flagWidget));

    final fWidget = tester.firstWidget(find.byType(Flag)) as Flag;
    final svgPictureWidget = tester.firstWidget(find.byType(SvgPicture)) as SvgPicture;

    expect(fWidget.width, 100);
    expect(fWidget.height, 100);

    expect(svgPictureWidget.width, fWidget.width);
    expect(svgPictureWidget.height, fWidget.height);
  });
}
