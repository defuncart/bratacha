import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/modules/dialog_manager/dialog_manager.dart';
import 'package:bratacha/modules/dialog_manager/src/models/responses/base_dialog_response.dart';
import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:bratacha/widgets/common/buttons/custom_elevated_button.dart';
import 'package:bratacha/widgets/common/panels/hard_difficulty_panel/hard_difficulty_cubit.dart';
import 'package:bratacha/widgets/common/panels/hard_difficulty_panel/hard_difficulty_panel.dart';
import 'package:bratacha/widgets/common/panels/language_panel/language_cubit.dart';
import 'package:bratacha/widgets/common/panels/language_panel/language_panel.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/settings_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  // ensure localizations are setup
  AppLocalizations.load(Locale('en'));

  final playerDataService = _MockPlayerDataService();
  final dialogService = _MockDialogService();
  final widget = MultiBlocProvider(
    providers: [
      BlocProvider<HardDifficultyCubit>(
        create: (_) => HardDifficultyCubit(playerDataService),
      ),
      BlocProvider<LanguageCubit>(
        create: (_) => LanguageCubit(playerDataService),
      ),
    ],
    child: SettingsTab(),
  );

  testWidgets('Ensure widget tree is correct', (tester) async {
    await tester.pumpWidget(MaterialApp(home: widget));

    expect(find.byType(SettingsTab), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);
    expect(find.text(AppLocalizations.settingsTabLanguageLabel), findsOneWidget);
    expect(find.byType(LanguagePanel), findsOneWidget);
    expect(find.byType(HardDifficultyPanel), findsOneWidget);
    expect(find.byType(CustomElevatedButton), findsNWidgets(3));
  });

  testWidgets('Ensure reset progress button is clickable', (tester) async {
    await tester.pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<IDialogService>(
            create: (_) => dialogService,
          ),
          RepositoryProvider<IPlayerDataService>(
            create: (_) => playerDataService,
          ),
        ],
        child: MaterialApp(home: widget),
      ),
    );

    final button = find.byType(CustomElevatedButton).at(0);

    dialogService.setResponse(ConfirmDialogResponse.positive());

    await tester.tap(button);

    verify(playerDataService.reset());

    dialogService.setResponse(ConfirmDialogResponse.negative());

    await tester.tap(button);

    verifyNever(playerDataService.reset());
  });

  testWidgets('Ensure data privacy button is clickable', (tester) async {
    await tester.pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<IDialogService>(
            create: (_) => dialogService,
          ),
          RepositoryProvider<IPlayerDataService>(
            create: (_) => playerDataService,
          ),
        ],
        child: MaterialApp(home: widget),
      ),
    );

    final button = find.byType(CustomElevatedButton).at(1);

    dialogService.setResponse(CustomDialogResponse(buttonIndexPressed: 1));

    await tester.tap(button);
  });

  testWidgets('Ensure credits button is clickable', (tester) async {
    await tester.pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<IDialogService>(
            create: (_) => dialogService,
          ),
          RepositoryProvider<IPlayerDataService>(
            create: (_) => playerDataService,
          ),
        ],
        child: MaterialApp(home: widget),
      ),
    );

    final button = find.byType(CustomElevatedButton).at(2);

    dialogService.setResponse(CustomDialogResponse(buttonIndexPressed: 0));

    await tester.tap(button);
  });
}

class _MockPlayerDataService extends Mock implements IPlayerDataService {
  @override
  String get language => 'en';

  @override
  bool get isHardDifficulty => false;
}

class _MockDialogService extends Mock implements IDialogService {
  BaseDialogResponse _response;

  void setResponse(BaseDialogResponse response) => _response = response;

  @override
  Future<InformativeDialogResponse> requestInformativeDialog(InformativeDialogRequest request) async =>
      await Future.value(_response as InformativeDialogResponse);

  @override
  Future<ConfirmDialogResponse> requestConfirmDialog(ConfirmDialogRequest request) async =>
      await Future.value(_response as ConfirmDialogResponse);

  @override
  Future<CustomDialogResponse> requestCustomDialog(CustomDialogRequest request) async =>
      await Future.value(_response as CustomDialogResponse);
}
