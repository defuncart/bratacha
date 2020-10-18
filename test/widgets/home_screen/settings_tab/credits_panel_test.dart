import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/widgets/common/panels/developer_panel.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/credits_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // ensure localizations are setup
  AppLocalizations.load(Locale('en'));

  testWidgets('Ensure widget tree is correct', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: CreditsPanel()),
    );

    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(Text), findsOneWidget);
    expect(find.byType(SizedBox), findsOneWidget);
    expect(find.byType(DeveloperPanel), findsOneWidget);
    expect(find.text(AppLocalizations.creditsDialogDescriptionLabel1), findsOneWidget);
  });
}
