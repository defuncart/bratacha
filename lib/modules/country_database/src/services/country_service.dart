import '../enums/continent.dart';
import '../models/country.dart';

part 'country_service.g.dart';

abstract class CountryService {
  /// Returns all countries
  static List<Country> get countries => _countries;

  /// Returns a country by id
  static Country countryWithId(String id) => _countries.firstWhere(
        (country) => country.id == id,
        orElse: () => null,
      );
}
