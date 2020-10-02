// ignore_for_file: always_use_package_imports
import '../enums/continent.dart';
import '../models/country.dart';

part 'country_service.g.dart';

class CountryService {
  /// Retuns all countries
  static List<Country> get countries => _countries;
}
