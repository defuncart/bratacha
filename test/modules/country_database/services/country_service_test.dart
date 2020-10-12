import 'package:bratacha/modules/country_database/country_database.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('CountryService', () {
    expect(CountryService.countries, isNotNull);
    expect(CountryService.countryWithId('de'), isNotNull);
    expect(CountryService.countryWithId('bla'), isNull);
  });
}
