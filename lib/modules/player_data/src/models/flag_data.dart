import 'package:hive/hive.dart';

import '../configs/hive_adapter_type.dart';

part 'flag_data.g.dart';

/// A model represeting a player's data on a given country
@HiveType(typeId: HiveAdapterType.flagData)
class FlagData extends HiveObject {
  FlagData({required this.id});

  /// The country's id
  @HiveField(0)
  final String id;

  @HiveField(1)
  late int _attempts;

  /// The number of attempts
  int get attempts => _attempts;

  @HiveField(2)
  late int _timesCorrect;

  /// The number of times correct
  int get timesCorrect => _timesCorrect;

  /// The percentage (between 0 and 1) that the player was correct
  double get percentageCorrect => attempts > 0 ? timesCorrect / attempts : 0;

  /// Updates the progress
  void updateProgress({required bool answeredCorrectly}) {
    _attempts++;
    if (answeredCorrectly) {
      _timesCorrect++;
    }
  }

  /// Resets the progress
  void reset() {
    _attempts = 0;
    _timesCorrect = 0;
  }

  @override
  String toString() =>
      '{$id: {attempts: $attempts, timesCorrect: $timesCorrect, percentageCorrect: $percentageCorrect}}';
}
