import 'package:bratacha/widgets/common/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Ensure widget tree is correct', (tester) async {
    final widget = Flag(
      'de',
      width: 100,
      height: 100,
    );

    await tester.pumpWidget(MaterialApp(home: widget));

    expect(find.byType(Flag), findsOneWidget);
    expect(find.byType(SvgPicture), findsOneWidget);
  });

  testWidgets('Ensure widget properties are correct', (tester) async {
    final width = 100.0;
    final height = 100.0;
    final widget = Flag(
      'de',
      width: width,
      height: height,
    );

    await tester.pumpWidget(MaterialApp(home: widget));

    final flagWidget = tester.firstWidget(find.byType(Flag)) as Flag;
    final svgPictureWidget = tester.firstWidget(find.byType(SvgPicture)) as SvgPicture;

    expect(widget.width, width);
    expect(widget.height, width);
    expect(flagWidget.width, width);
    expect(flagWidget.height, width);

    expect(svgPictureWidget.width, flagWidget.width);
    expect(svgPictureWidget.height, flagWidget.height);
  });

  test('countryCode null value triggers assertion', () {
    expect(
      () => Flag(null),
      throwsAssertionError,
    );
  });

  test('width != height triggers assertion', () {
    expect(
      () => Flag(
        'de',
        width: 100,
        height: 200,
      ),
      throwsAssertionError,
    );
  });
}
