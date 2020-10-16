import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/language_cubit.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/language_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  // ensure localizations are setup
  AppLocalizations.load(Locale('en'));

  testWidgets('Ensure widget tree is correct', (tester) async {
    await tester.pumpWidget(
      BlocProvider<LanguageCubit>(
        create: (_) => LanguageCubit(_MockPlayerDataService()),
        child: MaterialApp(
          home: Scaffold(
            body: LanguagePanel(),
          ),
        ),
      ),
    );

    expect(find.byType(LanguagePanel), findsOneWidget);
    expect(find.byType(Row), findsNWidgets(2));
  });
}

class _MockPlayerDataService extends Mock implements IPlayerDataService {
  String _langauge;

  _MockPlayerDataService({String language = 'en'}) : _langauge = language;

  @override
  String get language => _langauge;

  @override
  set language(String value) => _langauge = value;
}
