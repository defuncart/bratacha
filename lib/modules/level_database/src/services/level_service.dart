part 'level_service.g.dart';

class LevelService {
  /// Retuns the number of levels
  int get numberLevels => _levels.length;

  /// Retuns the countries for a given level index (beginning at zero)
  List<String> countryIdsForLevel(int level) {
    if (level >= 0 && level < _levels.length) {
      return _levels[level];
    }

    return null;
  }
}
