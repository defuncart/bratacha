import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../player_data.dart';
import '../configs/hive_adapter_type.dart';
import 'i_flag_data_service.dart';

/// A database of player's progress on flags
class FlagDataService implements IFlagDataService {
  /// A box to store objects
  Box<FlagData> _box;

  /// A name for the box
  static const _boxName = 'flag_data';

  /// Updates the progress for a given id
  @override
  void updateProgress({@required String id, @required bool answeredCorrectly}) {
    try {
      final flagData = flagDataWithId(id);
      flagData.updateProgress(answeredCorrectly: answeredCorrectly);
      flagData.save();
    } catch (_) {}
  }

  @override
  @visibleForTesting
  FlagData flagDataWithId(String id) {
    final flagData = _box.get(id);
    if (flagData == null) {
      throw Exception('FlagData with id $id does not exists!');
    }

    return flagData;
  }

  /// Initializes the database
  @override
  Future<void> initialize() async {
    if (!await Hive.isAdapterRegistered(HiveAdapterType.flagData)) {
      await Hive.registerAdapter(FlagDataAdapter());
    }

    _box = await Hive.openBox(_boxName);
  }

  /// Resyncs the database for a list of ids
  @override
  Future<void> resync({@required List<String> ids}) async {
    for (final id in ids) {
      if (!_box.containsKey(id)) {
        await _box.put(id, FlagData(id: id)..reset());
      }
    }
  }

  /// Resets all the player's country progress
  @override
  void reset() {
    for (final flagData in _box.values) {
      flagData.reset();
      flagData.save();
    }
  }

  // coverage:ignore-start
  /// DEBUG: Prints contents of db to the console
  @override
  void debugPrint() {
    for (final flagData in _box.values) {
      print(flagData);
    }
  }
  // coverage:ignore-end
}
