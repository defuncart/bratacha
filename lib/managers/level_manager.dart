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
      return _levelService.countryIdsForLevel(level).map((id) => CountryService.countryWithId(id)).toList();
    }

    throw (ArgumentError('Invalid level $level'));
  }

  /// Returns the progress for a given level index (beginning at zero)
  double progressForLevel(int level) {
    final ids = countriesForLevel(level).map((country) => country.id).toList();
    final numCorrectlyAnswered =
        ids.map((id) => _playerDataService.hasCorrectlyAnswered(id: id)).where((e) => e).length;
    return numCorrectlyAnswered / (ids.length);
  }
}
