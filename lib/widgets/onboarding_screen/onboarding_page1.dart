import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/widgets/common/panels/language_panel/language_panel.dart';
import 'package:flutter/material.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(
          AppLocalizations.onboardingPage1TextLabel1,
          style: Theme.of(context).textTheme.displaySmall,
        ),
        Text(
          AppLocalizations.onboardingPage1TextLabel2,
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.justify,
        ),
        Column(
          children: [
            Text(AppLocalizations.onboardingPage1TextLabel3),
            const SizedBox(height: 8),
            const LanguagePanel(presentConfirmationDialog: false),
          ],
        ),
        Center(
          child: Text(
            AppLocalizations.onboardingGeneralSettingLabel,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
