import 'package:meta/meta.dart';

part 'level_service.g.dart';

class LevelService {
  /// Returns the number of levels
  int get numberLevels => _levels.length;

  /// Returns the countries for a given level index (beginning at zero)
  List<String> countryIdsForLevel(int level) {
    if (level >= 0 && level < _levels.length) {
      return _levels[level].countries;
    }

    return null;
  }

  /// Returns the score required to unlock a given level index (beginning at zero)
  int scoreToUnlock(int level) {
    if (level >= 0 && level < _levels.length) {
      return _levels[level].scoreToUnlock;
    }

    return null;
  }
}

class _Level {
  final int scoreToUnlock;
  final List<String> countries;

  const _Level({
    @required this.scoreToUnlock,
    @required this.countries,
  })  : assert(scoreToUnlock != null),
        assert(countries != null);
}
