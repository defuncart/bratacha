import 'package:bratacha/widgets/common/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$Flag', () {
    testWidgets('Ensure widget tree is correct', (tester) async {
      final widget = Flag(
        'de',
        size: 100,
      );

      await tester.pumpWidget(MaterialApp(home: widget));

      expect(find.byType(Flag), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
    });

    testWidgets('Ensure widget properties are correct', (tester) async {
      final size = 100.0;
      final widget = Flag(
        'de',
        size: size,
      );

      await tester.pumpWidget(MaterialApp(home: widget));

      final flagWidget = tester.firstWidget(find.byType(Flag)) as Flag;
      final svgPictureWidget = tester.firstWidget(find.byType(SvgPicture)) as SvgPicture;

      expect(widget.size, size);
      expect(flagWidget.size, size);

      expect(svgPictureWidget.width, flagWidget.size);
      expect(svgPictureWidget.height, flagWidget.size);
    });

    test('size <0 triggers assertion', () {
      expect(
        () => Flag(
          'de',
          size: 0,
        ),
        throwsAssertionError,
      );
    });
  });
}
