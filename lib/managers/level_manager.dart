import 'package:bratacha/modules/country_database/country_database.dart';
import 'package:bratacha/modules/level_database/level_database.dart';

class LevelManager {
  static final _levelService = LevelService();

  /// Retuns the number of levels
  int get numberLevels => _levelService.numberLevels;

  /// Retuns the countries for a given level index (beginning at zero)
  List<Country> countriesForLevel(int level) {
    if (level >= 0 && level < numberLevels) {
      final countryIds = _levelService.countryIdsForLevel(level);
      final countries = <Country>[];
      countryIds.forEach((id) => countries.add(CountryService.countryWithId(id)));
      return countries;
    }

    return null;
  }
}
