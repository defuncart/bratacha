import 'package:bratacha/managers/level_manager.dart';
import 'package:bratacha/modules/player_data/src/services/i_flag_data_service.dart';
import 'package:bratacha/modules/player_data/src/services/i_player_data_service.dart';
import 'package:bratacha/services/game_service/i_game_service.dart';
import 'package:bratacha/services/url_launcher_service/i_url_launcher_service.dart';
import 'package:bratacha/widgets/game_screen/game_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockPlayerDataService extends Mock implements IPlayerDataService {}

class MockFlagDataService extends Mock implements IFlagDataService {}

class MockUrlLauncherService extends Mock implements IUrlLaucherService {}

class MockGameService extends Mock implements IGameService {}

class MockGameCubit extends Mock implements GameCubit {}

class MockLevelManager extends Mock implements LevelManager {}
