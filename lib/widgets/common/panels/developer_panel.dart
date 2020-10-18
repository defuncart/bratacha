import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/widgets/common/text/clickable_text.dart';
import 'package:flutter/material.dart';

class DeveloperPanel extends StatelessWidget {
  const DeveloperPanel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClickableText(AppLocalizations.developerPanelLabel);
  }
}
