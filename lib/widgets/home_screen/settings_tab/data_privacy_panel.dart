import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/widgets/common/text/clickable_text.dart';
import 'package:flutter/material.dart';

const double _spacerHeight = 16;

class DataPrivacyPanel extends StatelessWidget {
  const DataPrivacyPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClickableText(context.l10n.dataPrivacyPanelLabel1),
        const SizedBox(height: _spacerHeight),
        Text(
          context.l10n.dataPrivacyPanelLabel2,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: _spacerHeight),
        ClickableText(context.l10n.developerPanelLabel),
      ],
    );
  }
}
