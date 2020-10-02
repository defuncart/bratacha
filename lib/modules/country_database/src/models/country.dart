// ignore: always_use_package_imports
import '../enums/continent.dart';

/// A model representing a country
class Country {
  /// The country's two-letter key (i.e. de)
  final String key;

  /// The continent to which the country belongs (i.e. Continent.europe)
  final Continent continent;

  const Country({
    this.key,
    this.continent,
  });

  @override
  String toString() => '{key: $key, continent: $continent}';
}
