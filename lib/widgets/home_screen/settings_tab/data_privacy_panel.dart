import 'package:bratacha/extensions/iterable_widget_extension.dart';
import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/widgets/common/text/clickable_text.dart';
import 'package:flutter/material.dart';

class DataPrivacyPanel extends StatelessWidget {
  const DataPrivacyPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClickableText(context.l10n.dataPrivacyPanelLabel1),
        Text(context.l10n.dataPrivacyPanelLabel2),
        Text(context.l10n.disclaimerPoliticsLabel),
        ClickableText(context.l10n.developerPanelLabel),
      ].intersperse(const SizedBox(height: 16)),
    );
  }
}
