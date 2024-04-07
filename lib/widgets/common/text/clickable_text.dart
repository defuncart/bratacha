import 'package:bratacha/widgets/common/text/clickable_text_span.dart';
import 'package:flutter/material.dart';

/// Assumes text link is markdown
///
/// For instance, `here is a [link](https://github.com/defuncart/)`
class ClickableText extends StatelessWidget {
  const ClickableText(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final spanModels = convert(text);

    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          for (final spanModel in spanModels)
            if (spanModel is LinkSpan)
              ClickableTextSpan(
                text: spanModel.text,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
                url: spanModel.link,
              )
            else
              TextSpan(
                text: spanModel.text,
              ),
        ],
      ),
    );
  }
}

List<BaseSpan> convert(String input) {
  final regExp = RegExp(r'(\[(.*?)\]\(.*?\))');

  final spanModels = <BaseSpan>[];
  input.splitMapJoin(
    regExp,
    onMatch: (match) {
      final components = match.group(0)!.split('](');
      assert(components.length == 2);
      spanModels.add(LinkSpan(components[0].substring(1), components[1].substring(0, components[1].length - 1)));
      return '';
    },
    onNonMatch: (nonMatch) {
      if (nonMatch.isNotEmpty) {
        spanModels.add(RegularSpan(nonMatch));
      }
      return '';
    },
  );

  return spanModels;
}

abstract class BaseSpan {
  final String text;

  const BaseSpan(this.text);

  @override
  String toString() => 'text: $text';
}

class RegularSpan extends BaseSpan {
  const RegularSpan(super.text);

  @override
  String toString() => '{${super.toString()}}';
}

class LinkSpan extends BaseSpan {
  final String link;

  const LinkSpan(super.text, this.link);

  @override
  String toString() => '{${super.toString()}, link: $link}';
}
