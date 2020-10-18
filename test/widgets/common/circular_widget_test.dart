import 'package:bratacha/widgets/common/circular_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Ensure widget tree is correct', (tester) async {
    final widget = CircularWidget(
      radius: 100,
      child: Container(color: Colors.black),
    );

    await tester.pumpWidget(MaterialApp(home: widget));

    expect(find.byType(CircularWidget), findsOneWidget);
    expect(find.byType(ClipOval), findsOneWidget);
    expect(find.byType(Container), findsNWidgets(2));
  });

  testWidgets('Ensure widget properties are correct', (tester) async {
    final widget = CircularWidget(
      radius: 100,
      child: Container(color: Colors.black),
    );

    await tester.pumpWidget(MaterialApp(home: widget));

    final circularWidget = tester.firstWidget(find.byType(CircularWidget)) as CircularWidget;

    expect(circularWidget.radius, 100);
  });

  test('child null value triggers assertion', () {
    expect(
      () => CircularWidget(
        child: null,
        radius: 100,
      ),
      throwsAssertionError,
    );
  });

  test('radius null value triggers assertion', () {
    expect(
      () => CircularWidget(
        child: Container(color: Colors.black),
        radius: null,
      ),
      throwsAssertionError,
    );
  });

  test('radius <= 0 value triggers assertion', () {
    expect(
      () => CircularWidget(
        child: Container(color: Colors.black),
        radius: 0,
      ),
      throwsAssertionError,
    );
  });
}
