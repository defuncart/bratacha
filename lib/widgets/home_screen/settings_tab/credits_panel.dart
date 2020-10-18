import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/widgets/common/panels/developer_panel.dart';
import 'package:flutter/material.dart';

class CreditsPanel extends StatelessWidget {
  const CreditsPanel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppLocalizations.creditsDialogDescriptionLabel1,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        SizedBox(height: 8),
        DeveloperPanel(),
      ],
    );
  }
}
