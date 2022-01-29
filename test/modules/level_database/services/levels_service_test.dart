import 'package:bratacha/modules/level_database/src/services/level_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$LevelService', () {
    late LevelService levelService;

    setUp(() {
      levelService = LevelService();
    });

    group('countryIdsForLevel', () {
      test('when level is valid, expect returns normally', () {
        for (var i = 0; i < 10; i++) {
          expect(() => levelService.countryIdsForLevel(i), returnsNormally);
        }
      });

      test('when level is invalid, expect argument error', () {
        expect(() => levelService.countryIdsForLevel(-1), throwsArgumentError);
      });
    });

    group('scoreToUnlock', () {
      test('when level is valid, expect returns normally', () {
        for (var i = 0; i < 10; i++) {
          expect(() => levelService.scoreToUnlock(i), returnsNormally);
        }
      });

      test('when level is invalid, expect argument error', () {
        expect(() => levelService.scoreToUnlock(-1), throwsArgumentError);
      });
    });
  });
}
