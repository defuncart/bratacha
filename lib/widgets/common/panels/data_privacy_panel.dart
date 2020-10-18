import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/widgets/common/text/clickable_text.dart';
import 'package:flutter/material.dart';

class DataPrivacyPanel extends StatelessWidget {
  final double spacerHeight;

  const DataPrivacyPanel({
    Key key,
    this.spacerHeight = 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClickableText(AppLocalizations.dataPrivacyPanelLabel1),
        SizedBox(height: spacerHeight),
        Text(
          AppLocalizations.dataPrivacyPanelLabel2,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}
