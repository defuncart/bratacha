import 'package:bratacha/modules/country_database/country_database.dart';
import 'package:bratacha/modules/level_database/level_database.dart';

class LevelManager {
  static final _levelService = LevelService();

  /// Retuns the number of levels
  int get numberLevels => _levelService.numberLevels;

  /// Retuns the countries for a given level index (beginning at zero)
  List<Country> countriesForLevel(int level) {
    if (level >= 0 && level < numberLevels) {
      return CountryService.countriesWithIds(_levelService.countryIdsForLevel(level));
    }

    return null;
  }
}
