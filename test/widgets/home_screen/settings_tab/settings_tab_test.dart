import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/modules/dialog_manager/dialog_manager.dart';
import 'package:bratacha/modules/dialog_manager/src/models/responses/base_dialog_response.dart';
import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:bratacha/services/url_launcher_service/i_url_launcher_service.dart';
import 'package:bratacha/widgets/common/buttons/custom_elevated_button.dart';
import 'package:bratacha/widgets/common/panels/hard_difficulty_panel/hard_difficulty_cubit.dart';
import 'package:bratacha/widgets/common/panels/hard_difficulty_panel/hard_difficulty_panel.dart';
import 'package:bratacha/widgets/common/panels/language_panel/language_cubit.dart';
import 'package:bratacha/widgets/common/panels/language_panel/language_panel.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/feedback_panel.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/settings_popup_menu_button.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/settings_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  // ensure localizations are setup
  AppLocalizations.load(const Locale('en'));

  group('$SettingsTab', () {
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
      child: RepositoryProvider<IUrlLaucherService>(
        create: (_) => _MockUrlLauncherService(),
        child: const SettingsTab(),
      ),
    );

    testWidgets('Ensure widget tree is correct', (tester) async {
      await tester.pumpWidget(MaterialApp(home: widget));

      expect(find.byType(SettingsTab), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(SettingsPopupMenuButton), findsOneWidget);
      expect(find.byType(Column), findsNWidgets(2));
      expect(find.text(AppLocalizations.settingsTabLanguageLabel), findsOneWidget);
      expect(find.byType(LanguagePanel), findsOneWidget);
      expect(find.byType(HardDifficultyPanel), findsOneWidget);
      expect(find.byType(CustomElevatedButton), findsOneWidget);
      expect(find.byType(FeedbackPanel), findsOneWidget);
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

      final button = find.byType(CustomElevatedButton);

      dialogService.setResponse(const ConfirmDialogResponse.positive());

      when(() => playerDataService.reset()).thenAnswer((_) async {});

      await tester.tap(button);

      verify(() => playerDataService.reset());

      dialogService.setResponse(const ConfirmDialogResponse.negative());

      await tester.tap(button);

      verifyNever(() => playerDataService.reset());
    });
  });
}

class _MockPlayerDataService extends Mock implements IPlayerDataService {
  @override
  String get language => 'en';

  @override
  bool get isHardDifficulty => false;
}

class _MockDialogService extends Mock implements IDialogService {
  late BaseDialogResponse _response;

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

class _MockUrlLauncherService extends Mock implements IUrlLaucherService {}
