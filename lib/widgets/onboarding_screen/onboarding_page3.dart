import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/widgets/common/panels/data_privacy_panel.dart';
import 'package:bratacha/widgets/common/panels/developer_panel.dart';
import 'package:flutter/material.dart';

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.l10n.onboardingPage3TextLabel1),
        Text(context.l10n.onboardingPage3TextLabel2),
        Text(context.l10n.feedbackPanelLabel1),
        const DataPrivacyPanel(),
        const DeveloperPanel(),
      ],
    );
  }
}
