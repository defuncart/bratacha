import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:bratacha/modules/player_data/src/services/flag_data_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
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
            flagDataService.resync(ids: ['id']);
          },
        );

        final playerDataService = PlayerDataService();
        await playerDataService.initialize();

        expect(playerDataService.language, 'en');
        expect(playerDataService.isHardMode, isFalse);
        expect(playerDataService.hasCorrectlyAnswered(id: 'id'), isFalse);

        // language
        playerDataService.language = 'de';
        expect(playerDataService.language, 'de');

        // isHardMode
        playerDataService.isHardMode = true;
        expect(playerDataService.isHardMode, true);

        // updateProgress, hasCorrectlyAnswered
        playerDataService.updateProgress(id: 'id', answeredCorrectly: true);
        expect(playerDataService.hasCorrectlyAnswered(id: 'id'), isTrue);

        // reset
        await playerDataService.reset();
        expect(playerDataService.language, 'en');
        expect(playerDataService.isHardMode, isFalse);
        expect(playerDataService.hasCorrectlyAnswered(id: 'id'), isFalse);
      },
    );
  });

  test('with MockFlagDataService', () async {
    await hiveWrapper(
      callback: () async {
        final mockFlagDataService = MockFlagDataService();
        final playerDataService = PlayerDataService();

        when(() => mockFlagDataService.initialize()).thenAnswer((_) async {});
        await playerDataService.initialize(flagDataService: mockFlagDataService);
        verify(() => mockFlagDataService.initialize()).called(1);

        when(() => mockFlagDataService.resync(ids: ['de'])).thenAnswer((_) async {});
        await playerDataService.resync(ids: ['de']);
        verify(() => mockFlagDataService.resync(ids: ['de'])).called(1);

        playerDataService.updateProgress(id: 'de', answeredCorrectly: true);
        verify(() => mockFlagDataService.updateProgress(id: 'de', answeredCorrectly: true)).called(1);

        when(() => mockFlagDataService.flagDataWithId('de')).thenReturn(
          FlagData(id: 'de')
            ..reset()
            ..updateProgress(answeredCorrectly: true),
        );
        expect(playerDataService.hasCorrectlyAnswered(id: 'de'), isTrue);

        when(() => mockFlagDataService.reset()).thenAnswer((_) async {});
        playerDataService.resetAllCountryProgress();
        verify(() => mockFlagDataService.reset()).called(1);
      },
    );
  });
}
