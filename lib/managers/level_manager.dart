import 'package:bratacha/modules/country_database/country_database.dart';
import 'package:bratacha/modules/level_database/level_database.dart';
import 'package:bratacha/modules/player_data/player_data.dart';

class LevelManager {
  LevelManager(this._playerDataService);

  final _levelService = LevelService();
  final IPlayerDataService _playerDataService;

  /// Returns the number of levels
  int get numberLevels => _levelService.numberLevels;

  /// Returns the countries for a given level index (beginning at zero)
  List<Country> countriesForLevel(int level) {
    if (level >= 0 && level < numberLevels) {
      final countryIds = _levelService.countryIdsForLevel(level);
      final countries = <Country>[];
      for (final id in countryIds) {
        countries.add(CountryService.countryWithId(id));
      }
      return countries;
    }

    throw (ArgumentError('Invalid level $level'));
  }

  /// Returns whether a given level index (beginning at zero) is unlocked
  bool isLevelUnlocked(int level) => _playerDataService.score >= _levelService.scoreToUnlock(level);

  /// Returns the points required to unlock a given level index (beginning at zero)
  int scoreToUnlock(int level) => _levelService.scoreToUnlock(level);
}
