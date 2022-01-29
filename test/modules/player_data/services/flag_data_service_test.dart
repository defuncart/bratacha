import 'package:bratacha/modules/player_data/src/configs/hive_adapter_type.dart';
import 'package:bratacha/modules/player_data/src/services/flag_data_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import '../../hive_wrapper.dart';

void main() {
  test('$FlagDataService', () async {
    await hiveWrapper(
      callback: () async {
        final flagDataService = FlagDataService();
        await flagDataService.initialize();

        final isFlagDataAdapterRegistered = await Hive.isAdapterRegistered(HiveAdapterType.flagData);
        expect(isFlagDataAdapterRegistered, isTrue);

        //as the db is empty, expect error to be thrown
        expect(() => flagDataService.flagDataWithId('de'), throwsException);

        // populate db, expect to execute normally
        await flagDataService.resync(ids: ['de']);
        expect(() => flagDataService.flagDataWithId('de'), returnsNormally);

        // ensure updateProgress correctly implemented
        flagDataService.updateProgress(id: 'de', answeredCorrectly: true);
        expect(flagDataService.flagDataWithId('de').attempts, 1);
        expect(flagDataService.flagDataWithId('de').timesCorrect, 1);
        flagDataService.updateProgress(id: 'de', answeredCorrectly: false);
        expect(flagDataService.flagDataWithId('de').attempts, 2);
        expect(flagDataService.flagDataWithId('de').timesCorrect, 1);

        // ensure reset correctly implemented
        flagDataService.reset();
        expect(flagDataService.flagDataWithId('de').attempts, 0);
        expect(flagDataService.flagDataWithId('de').timesCorrect, 0);
      },
    );
  });
}
