import 'package:bratacha/widgets/common/circular_widget.dart';
import 'package:bratacha/widgets/common/panels/language_panel/langauge_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$LanguageButton', () {
    testWidgets('Ensure widget tree is correct', (tester) async {
      final widget = LanguageButton(
        languageCode: 'en',
        size: 100,
        isSelected: true,
        onPressed: () {},
      );

      await tester.pumpWidget(MaterialApp(home: widget));

      expect(find.byType(LanguageButton), findsOneWidget);
      expect(find.byType(Opacity), findsOneWidget);
      expect(find.byType(GestureDetector), findsOneWidget);
      expect(find.byType(CircularWidget), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
    });

    testWidgets('Ensure opacity is correct', (tester) async {
      var widget = LanguageButton(
        languageCode: 'en',
        isSelected: true,
        onPressed: () {},
      );

      await tester.pumpWidget(MaterialApp(home: widget));

      var languageButtonWidget = tester.firstWidget(find.byType(LanguageButton)) as LanguageButton;
      var opacityWidget = tester.firstWidget(find.byType(Opacity)) as Opacity;

      expect(languageButtonWidget.isSelected, isTrue);
      expect(opacityWidget.opacity, 1);

      widget = LanguageButton(
        languageCode: 'en',
        isSelected: false,
        onPressed: () {},
      );

      await tester.pumpWidget(MaterialApp(home: widget));

      languageButtonWidget = tester.firstWidget(find.byType(LanguageButton)) as LanguageButton;
      opacityWidget = tester.firstWidget(find.byType(Opacity)) as Opacity;

      expect(languageButtonWidget.isSelected, isFalse);
      expect(opacityWidget.opacity, isNot(1));
    });

    testWidgets('Ensure onPressed is called', (tester) async {
      var isPressed = false;
      final widget = LanguageButton(
        languageCode: 'en',
        isSelected: true,
        onPressed: () => isPressed = true,
      );

      await tester.pumpWidget(MaterialApp(home: widget));

      expect(isPressed, isFalse);

      await tester.tap(find.byType(LanguageButton));

      expect(isPressed, isTrue);
    });

    testWidgets('Ensure size is correct', (tester) async {
      final widget = LanguageButton(
        languageCode: 'en',
        size: 100,
        isSelected: true,
        onPressed: () {},
      );

      await tester.pumpWidget(MaterialApp(home: widget));

      final languageButtonWidget = tester.firstWidget(find.byType(LanguageButton)) as LanguageButton;

      expect(languageButtonWidget.size, 100);
      expect(languageButtonWidget.size, 100);
    });

    test('size <= 0 value triggers assertion', () {
      expect(
        () => LanguageButton(
          languageCode: 'en',
          size: 0,
          isSelected: true,
          onPressed: () {},
        ),
        throwsAssertionError,
      );
    });
  });
}
