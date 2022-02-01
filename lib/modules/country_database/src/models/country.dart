import '../enums/continent.dart';

/// A model representing a country
class Country {
  /// The country's two-letter id (i.e. de)
  final String id;

  /// The continent to which the country belongs (i.e. Continent.europe)
  final Continent continent;

  /// A list of flag ids which are similar to the country
  final List<String> similarFlags;

  const Country({
    required this.id,
    required this.continent,
    required this.similarFlags,
  });

  @override
  String toString() => '{id: $id, continent: $continent, similarFlags: $similarFlags}';
}
