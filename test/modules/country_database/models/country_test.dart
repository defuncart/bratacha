import 'package:bratacha/modules/country_database/country_database.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Ensure Country is correctly constructed', () {
    final country = Country(id: 'de', continent: Continent.europe, similarFlags: ['be']);
    expect(country, isNotNull);
    expect(country.id, isNotNull);
    expect(country.id, 'de');
    expect(country.continent, isNotNull);
    expect(country.continent, Continent.europe);
    expect(country.similarFlags, isNotNull);
    expect(country.similarFlags, ['be']);
    expect(country.toString(), isNotNull);
  });
}
