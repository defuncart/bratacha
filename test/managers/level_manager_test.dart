import 'package:bratacha/managers/level_manager.dart';
import 'package:bratacha/modules/level_database/level_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks.dart';

void main() {
  group('$LevelManager', () {
    final levelService = LevelService();

    late LevelManager levelManager;
    late MockPlayerDataService mockPlayerDataService;

    setUp(() {
      mockPlayerDataService = MockPlayerDataService();
      levelManager = LevelManager(mockPlayerDataService);
    });

    test('numberLevels', () {
      expect(levelManager.numberLevels, levelService.numberLevels);
    });

    test('countriesForLevel', () {
      for (var i = 0; i < levelManager.numberLevels; i++) {
        expect(levelManager.countriesForLevel(i).length, levelService.countryIdsForLevel(i).length);
      }
    });

    group('progressForLevel', () {
      test('when all flags have been answered correctly, expect 100% for all levels', () {
        when(() => mockPlayerDataService.hasCorrectlyAnswered(id: any(named: 'id'))).thenReturn(true);
        for (var i = 0; i < levelManager.numberLevels; i++) {
          expect(levelManager.progressForLevel(i), 1);
        }
      });

      test(
        'when only one flag has been answered correctly for level 0, expect 5% for level 0 and 0% for all other levels',
        () {
          when(() => mockPlayerDataService.hasCorrectlyAnswered(id: any(named: 'id'))).thenReturn(false);
          when(() => mockPlayerDataService.hasCorrectlyAnswered(id: 'de')).thenReturn(true);
          for (var i = 0; i < levelManager.numberLevels; i++) {
            expect(levelManager.progressForLevel(i), i == 0 ? 0.05 : 0);
          }
        },
      );
    });
  });
}
