import 'package:meta/meta.dart';

/// A database of player's progress on flags
abstract class IFlagDataService {
  /// Updates the progress for a given id
  void updateProgress({@required String id, @required bool answeredCorrectly});

  /// Initializes the database
  Future<void> initialize();

  /// Resyncs the database for a list of ids
  Future<void> resync({@required List<String> ids});

  /// Resets all flag progress
  void reset();

  /// DEBUG: Prints contents of db to the console
  void debugPrint();
}
