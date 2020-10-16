import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:bratacha/widgets/common/panels/hard_difficulty_panel/hard_difficulty_cubit.dart';
import 'package:bratacha/widgets/common/panels/hard_difficulty_panel/hard_difficulty_panel.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/language_cubit.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/language_panel.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/settings_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  // ensure localizations are setup
  AppLocalizations.load(Locale('en'));

  testWidgets('Ensure widget tree is correct', (tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<HardDifficultyCubit>(
            create: (_) => HardDifficultyCubit(_MockPlayerDataService()),
          ),
          BlocProvider<LanguageCubit>(
            create: (_) => LanguageCubit(_MockPlayerDataService()),
          ),
        ],
        child: MaterialApp(
          home: SettingsTab(),
        ),
      ),
    );

    expect(find.byType(SettingsTab), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(HardDifficultyPanel), findsOneWidget);
    expect(find.byType(LanguagePanel), findsOneWidget);
  });
}

class _MockPlayerDataService extends Mock implements IPlayerDataService {
  @override
  String get language => 'en';

  @override
  bool get isHardDifficulty => false;
}
