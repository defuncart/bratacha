// ignore_for_file: always_use_package_imports
import '../enums/continent.dart';
import '../models/country.dart';

part 'country_service.g.dart';

class CountryService {
  /// Returns all countries
  static List<Country> get countries => _countries;

  /// Returns a selection of countries by ids
  static List<Country> countriesWithIds(List<String> ids) =>
      _countries.where((country) => ids.contains(country.key)).toList();
}
