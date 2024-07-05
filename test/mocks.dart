import 'package:bratacha/managers/level_manager.dart';
import 'package:bratacha/modules/dialog_manager/dialog_manager.dart';
import 'package:bratacha/modules/player_data/src/services/i_flag_data_service.dart';
import 'package:bratacha/modules/player_data/src/services/i_player_data_service.dart';
import 'package:bratacha/services/app_info_service/i_app_info_service.dart';
import 'package:bratacha/services/game_service/i_game_service.dart';
import 'package:bratacha/services/url_launcher_service/i_url_launcher_service.dart';
import 'package:bratacha/widgets/common/panels/hard_difficulty_panel/hard_difficulty_cubit.dart';
import 'package:bratacha/widgets/common/panels/language_panel/language_cubit.dart';
import 'package:bratacha/widgets/game_screen/game_cubit.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';

class MockPlayerDataService extends Mock implements IPlayerDataService {}

class MockFlagDataService extends Mock implements IFlagDataService {}

class MockUrlLauncherService extends Mock implements IUrlLaucherService {}

class MockGameService extends Mock implements IGameService {}

class MockGameCubit extends Mock implements GameCubit {}

class MockLevelManager extends Mock implements LevelManager {}

class MockDialogService extends Mock implements IDialogService {}

class FakeConfirmDialogRequest extends Fake implements ConfirmDialogRequest {}

class FakeCustomDialogRequest extends Fake implements CustomDialogRequest {}

class MockLanguageCubit extends Mock implements LanguageCubit {}

class MockBuildContext extends Mock implements BuildContext {}

class MockHardDifficultyCubit extends Mock implements HardDifficultyCubit {}

class MockAppInfoService extends Mock implements IAppInfoService {}
