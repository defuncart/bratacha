import 'package:bratacha/modules/country_database/country_database.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$Country', () {
    test('Ensure model is correctly constructed', () {
      final country = Country(id: 'de', continent: Continent.europe, similarFlags: ['be']);
      expect(country.id, 'de');
      expect(country.continent, Continent.europe);
      expect(country.similarFlags, ['be']);
      expect(country.toString(), isNot('Instance of \'Country\''));
    });
  });
}
