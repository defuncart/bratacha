import 'package:bratacha/modules/country_database/country_database.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$CountryService', () {
    test('countries', () {
      expect(CountryService.countries, isList);
      expect(CountryService.countries, hasLength(193));
    });

    test('countryWithId', () {
      expect(CountryService.countryWithId('de'), isA<Country>());
      expect(() => CountryService.countryWithId('bla'), throwsStateError);
    });
  });
}
