import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

// ignore: always_use_package_imports
import '../configs/hive_adapter_type.dart';

part 'country_data.g.dart';

/// A model represeting a player's data on a given country
@HiveType(typeId: HiveAdapterType.countryData)
class CountryData {
  /// The country's id
  @HiveField(0)
  final String id;

  /// The number of attempts
  @HiveField(1)
  int attempts;

  /// The number of times correct
  @HiveField(2)
  int timesCorrect;

  CountryData({@required this.id});

  /// The percentage (between 0 and 1) that the player was correct
  double get percentageCorrect => attempts > 0 ? timesCorrect / attempts : 0;

  /// Updates the progress
  void updateProgress({@required bool answeredCorrectly}) {
    attempts++;
    if (answeredCorrectly) {
      timesCorrect++;
    }
  }

  /// Resets the progress
  void reset() {
    attempts = 0;
    timesCorrect = 0;
  }

  @override
  String toString() =>
      '{$id: {attempts: $attempts, timesCorrect: $timesCorrect, percentageCorrect: $percentageCorrect}}';
}