import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/widgets/common/text/clickable_text.dart';
import 'package:flutter/material.dart';

class CreditsPanel extends StatelessWidget {
  const CreditsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.creditsDialogDescriptionLabel1,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        ClickableText(context.l10n.developerPanelLabel),
      ],
    );
  }
}
