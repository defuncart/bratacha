import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:bratacha/modules/player_data/src/services/flag_data_service.dart';
import 'package:bratacha/modules/player_data/src/services/i_flag_data_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';
import 'package:mocktail/mocktail.dart';

import '../../hive_wrapper.dart';

void main() {
  test('', () async {
    await hiveWrapper(
      cleanUpOnSetUp: false,
      callback: () async {
        await hiveWrapper(
            cleanUpOnSetUp: false,
            callback: () async {
              final flagDataService = FlagDataService();
              await flagDataService.initialize();
            });

        final playerDataService = PlayerDataService();
        await playerDataService.initialize();

        expect(playerDataService.language, isNotNull);
        expect(playerDataService.isHardDifficulty, isNotNull);
        expect(playerDataService.score, isNotNull);

        // language
        playerDataService.language = 'de';
        expect(playerDataService.language, 'de');

        // isHardDifficulty
        playerDataService.isHardDifficulty = true;
        expect(playerDataService.isHardDifficulty, true);

        // score
        playerDataService.score = 100;
        expect(playerDataService.score, 100);

        // reset
        await playerDataService.reset();
        expect(playerDataService.language, isNot('de'));
        expect(playerDataService.isHardDifficulty, isNot(true));
        expect(playerDataService.score, isNot(100));

        await playerDataService.resync(ids: ['de']);
      },
    );
  });

  test('', () async {
    await hiveWrapper(
      callback: () async {
        final mockFlagDataService = _MockFlagDataService();
        final playerDataService = PlayerDataService();
        await playerDataService.initialize(flagDataService: mockFlagDataService);

        await playerDataService.resync(ids: ['de']);
        // verify(mockFlagDataService.resync(ids: ['de']));

        playerDataService.updateProgress(id: 'de', answeredCorrectly: true);
        // verify(mockFlagDataService.updateProgress(id: 'de', answeredCorrectly: true));

        playerDataService.resetAllCountryProgress();
        // verify(mockFlagDataService.reset());
      },
    );
  });
}

class _MockFlagDataService extends Mock implements IFlagDataService {
  @override
  void updateProgress({@required String id, @required bool answeredCorrectly}) {}

  @override
  FlagData flagDataWithId(String id) => null;

  @override
  Future<void> initialize() async {}

  @override
  Future<void> resync({@required List<String> ids}) async {}

  @override
  void reset() {}
}
