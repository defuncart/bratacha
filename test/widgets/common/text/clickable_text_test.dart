import 'package:bratacha/widgets/common/text/clickable_text.dart';
import 'package:bratacha/widgets/common/text/clickable_text_span.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('RegularSpan', () {
    final model = RegularSpan('bla');
    expect(model.text, 'bla');
    expect(model.toString(), isNotNull);
    expect(model.toString(), isNot('text: bla'));
    expect(model.toString(), isNot('Instance of \'RegularSpan\''));
  });

  test('RegularSpan', () {
    final model = LinkSpan('bla', 'https://bla.bla');
    expect(model.text, 'bla');
    expect(model.link, 'https://bla.bla');
    expect(model.toString(), isNotNull);
    expect(model.toString(), isNot('text: bla'));
    expect(model.toString(), isNot('Instance of \'RegularSpan\''));
  });

  test('convert', () {
    var spanModels = convert('[My Link](https://bla.bla)');
    expect(spanModels.length, 1);
    expect(spanModels.first, isInstanceOf<LinkSpan>());
    expect(spanModels.first.text, 'My Link');
    expect((spanModels.first as LinkSpan).link, 'https://bla.bla');

    spanModels = convert('Here is a [link](https://bla.bla).');
    expect(spanModels.length, 3);
    expect(spanModels[0], isInstanceOf<RegularSpan>());
    expect(spanModels[0].text, 'Here is a ');
    expect(spanModels[1], isInstanceOf<LinkSpan>());
    expect(spanModels[1].text, 'link');
    expect((spanModels[1] as LinkSpan).link, 'https://bla.bla');
    expect(spanModels[2], isInstanceOf<RegularSpan>());
    expect(spanModels[2].text, '.');
  });

  testWidgets('ClickableText', (tester) async {
    final widget = ClickableText('Here is a [link](https://bla.bla).');

    await tester.pumpWidget(MaterialApp(home: widget));

    // ensure widget tree is correct
    expect(find.byType(RichText), findsOneWidget);

    // ensure content is correct
    final richTextWidget = tester.firstWidget(find.byType(RichText)) as RichText;
    final textSpan = richTextWidget.text as TextSpan;

    expect(textSpan.children.length, 3);
    expect(textSpan.children[0], isInstanceOf<TextSpan>());
    expect(textSpan.children[1], isInstanceOf<ClickableTextSpan>());
    expect(textSpan.children[2], isInstanceOf<TextSpan>());

    // text null value triggers assertion
    expect(
      () => ClickableText(null),
      throwsAssertionError,
    );
  });
}
