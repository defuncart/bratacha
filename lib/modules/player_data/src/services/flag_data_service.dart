import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

// ignore_for_file: always_use_package_imports
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
    _box.get(id).updateProgress(answeredCorrectly: answeredCorrectly);
    _box.get(id).save();
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

  /// DEBUG: Prints contents of db to the console
  @override
  void debugPrint() {
    for (final flagData in _box.values) {
      print(flagData);
    }
  }
}
