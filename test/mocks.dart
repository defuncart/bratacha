import 'package:bratacha/modules/player_data/src/services/i_flag_data_service.dart';
import 'package:bratacha/modules/player_data/src/services/i_player_data_service.dart';
import 'package:bratacha/services/url_launcher_service/i_url_launcher_service.dart';
import 'package:mocktail/mocktail.dart';

class MockPlayerDataService extends Mock implements IPlayerDataService {}

class MockFlagDataService extends Mock implements IFlagDataService {}

class MockUrlLauncherService extends Mock implements IUrlLaucherService {}
