import 'package:bratacha/services/url_launcher_service/i_url_launcher_service.dart';
import 'package:flutter/material.dart';

class FeedbackPanel extends StatelessWidget {
  static const _translationsUrl =
      'https://docs.google.com/spreadsheets/d/1bfFT6_rA-9QEBTHy1YDpdP-lgQ42Cq4YV1AchvA21pY/edit?usp=sharing';
  static const _feedbackUrl = 'https://forms.gle/UL2nhvt8oeRH361E6';

  const FeedbackPanel({
    required this.urlLaucherService,
    super.key,
  });

  final IUrlLauncherService urlLaucherService;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Text(
              'Early Access',
              style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Bratacha is currently under development, available in an early access state. Your feedback is greatly appreciated!',
              style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () async => await urlLaucherService.openUrl(_feedbackUrl),
              child: const Text('Give Feedback'),
            ),
            const SizedBox(height: 16),
            Text(
              'If you are a native speaker of Belarusian, Irish or Welsh, please consider proofreading and updating the auto-generated translations.',
              style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () async => await urlLaucherService.openUrl(_translationsUrl),
              child: const Text('Proofread Translations'),
            ),
          ],
        ),
      ),
    );
  }
}
