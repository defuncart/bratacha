import 'package:bratacha/widgets/common/buttons/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Ensure widget tree is correct', (tester) async {
    final widget = CustomElevatedButton(
      onPressed: () {},
      buttonText: 'bla',
    );

    await tester.pumpWidget(MaterialApp(home: widget));

    expect(find.byType(CustomElevatedButton), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.byType(Text), findsOneWidget);
  });

  testWidgets('Ensure widget properties are correct', (tester) async {
    final buttonText = 'bla';
    final widget = CustomElevatedButton(
      onPressed: () {},
      buttonText: buttonText,
    );

    await tester.pumpWidget(MaterialApp(home: widget));

    final textWidget = tester.firstWidget(find.byType(Text)) as Text;

    expect(textWidget.data, buttonText);
    expect(widget.buttonText, buttonText);
  });

  testWidgets('Ensure onPressed is invoked', (tester) async {
    var isPressed = false;
    final widget = CustomElevatedButton(
      onPressed: () => isPressed = true,
      buttonText: 'bla',
    );

    await tester.pumpWidget(MaterialApp(home: widget));

    expect(isPressed, isFalse);

    await tester.tap(find.byType(CustomElevatedButton));

    expect(isPressed, isTrue);
  });

  test('buttonText null value triggers assertion', () {
    expect(
      () => CustomElevatedButton(
        onPressed: () {},
        buttonText: null,
      ),
      throwsAssertionError,
    );
  });

  test('onPressed null value triggers assertion', () {
    expect(
      () => CustomElevatedButton(
        onPressed: null,
        buttonText: 'bla',
      ),
      throwsAssertionError,
    );
  });
}
