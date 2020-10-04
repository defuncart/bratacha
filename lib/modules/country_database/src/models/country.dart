// ignore: always_use_package_imports
import '../enums/continent.dart';

/// A model representing a country
class Country {
  /// The country's two-letter id (i.e. de)
  final String id;

  /// The continent to which the country belongs (i.e. Continent.europe)
  final Continent continent;

  const Country({
    this.id,
    this.continent,
  });

  @override
  String toString() => '{id: $id, continent: $continent}';
}
