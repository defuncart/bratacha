import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/widgets/common/text/clickable_text.dart';
import 'package:flutter/material.dart';

class DataPrivacyPanel extends StatelessWidget {
  const DataPrivacyPanel({
    this.spacerHeight = 16.0,
    super.key,
  });

  final double spacerHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClickableText(context.l10n.dataPrivacyPanelLabel1),
        SizedBox(height: spacerHeight),
        Text(
          context.l10n.dataPrivacyPanelLabel2,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
