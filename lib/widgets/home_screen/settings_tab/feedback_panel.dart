import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/services/url_launcher_service/i_url_launcher_service.dart';
import 'package:flutter/material.dart';

class FeedbackPanel extends StatelessWidget {
  static const _url = 'https://forms.gle/UL2nhvt8oeRH361E6';

  const FeedbackPanel({
    required this.urlLaucherService,
    super.key,
  });

  final IUrlLaucherService urlLaucherService;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Text(
              AppLocalizations.feedbackPanelLabel1,
              style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              textAlign: TextAlign.center,
            ),
            TextButton(
              onPressed: () async => await urlLaucherService.openUrl(_url),
              child: Text(AppLocalizations.feedbackPanelGiveFeedbackButtonText),
            ),
          ],
        ),
      ),
    );
  }
}
