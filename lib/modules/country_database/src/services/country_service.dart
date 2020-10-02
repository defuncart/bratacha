import '../enums/continent.dart';
import '../models/country.dart';

part 'country_service.g.dart';

class CountryService {
  /// Retuns all countries
  static List<Country> get countries => _countries;
}
