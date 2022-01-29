import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:bratacha/modules/player_data/src/services/flag_data_service.dart';
import 'package:bratacha/modules/player_data/src/services/i_flag_data_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../hive_wrapper.dart';

void main() {
  test('$PlayerDataService', () async {
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

        expect(playerDataService.language, 'en');
        expect(playerDataService.isHardDifficulty, isFalse);
        expect(playerDataService.score, 0);

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
        expect(playerDataService.language, 'en');
        expect(playerDataService.isHardDifficulty, isNot(true));
        expect(playerDataService.isHardDifficulty, isFalse);
        expect(playerDataService.score, isNot(100));
        expect(playerDataService.score, 0);
      },
    );
  });

  test('with _MockFlagDataService', () async {
    await hiveWrapper(
      callback: () async {
        final mockFlagDataService = _MockFlagDataService();
        final playerDataService = PlayerDataService();

        when(() => mockFlagDataService.initialize()).thenAnswer((_) async {});
        await playerDataService.initialize(flagDataService: mockFlagDataService);
        verify(() => mockFlagDataService.initialize());

        when(() => mockFlagDataService.resync(ids: ['de'])).thenAnswer((_) async {});
        await playerDataService.resync(ids: ['de']);
        verify(() => mockFlagDataService.resync(ids: ['de']));

        playerDataService.updateProgress(id: 'de', answeredCorrectly: true);
        verify(() => mockFlagDataService.updateProgress(id: 'de', answeredCorrectly: true));

        playerDataService.resetAllCountryProgress();
        verify(() => mockFlagDataService.reset());
      },
    );
  });
}

class _MockFlagDataService extends Mock implements IFlagDataService {}
