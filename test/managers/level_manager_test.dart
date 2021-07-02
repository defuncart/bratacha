import 'package:bratacha/managers/level_manager.dart';
import 'package:bratacha/modules/level_database/level_database.dart';
import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final levelService = LevelService();
  var levelManager = LevelManager(_MockPlayerDataService());

  test('LevelManager', () {
    expect(levelManager.numberLevels, levelService.numberLevels);
    for (var i = 0; i < levelManager.numberLevels; i++) {
      expect(levelManager.countriesForLevel(i).length, levelService.countryIdsForLevel(i).length);
      expect(levelManager.scoreToUnlock(i), levelService.scoreToUnlock(i));
    }
  });

  // ensure that for all levels, that regarding score, correct levels are unlocked
  for (var i = 0; i < levelManager.numberLevels; i++) {
    test('When player\'s score <= requirement for level index $i, only levels up to $i are unlocked', () {
      levelManager = LevelManager(_MockPlayerDataService(score: levelService.scoreToUnlock(i)));
      final expectedValues = List.generate(levelManager.numberLevels, (index) => index <= i ? true : false);

      for (var j = 0; j < levelManager.numberLevels; j++) {
        expect(levelManager.isLevelUnlocked(j), expectedValues[j]);
      }
    });
  }
}

class _MockPlayerDataService extends Mock implements IPlayerDataService {
  int _score;

  _MockPlayerDataService({int score = 0}) : _score = score;

  @override
  int get score => _score;

  @override
  set score(int value) => _score = value;
}
