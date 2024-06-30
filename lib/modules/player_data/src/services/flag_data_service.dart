import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../../player_data.dart';
import '../configs/hive_adapter_type.dart';
import 'i_flag_data_service.dart';

class FlagDataService implements IFlagDataService {
  /// A box to store objects
  late Box<FlagData> _box;

  /// A name for the box
  static const _boxName = 'flag_data';

  @override
  void updateProgress({required String id, required bool answeredCorrectly}) {
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

  @override
  Future<void> initialize() async {
    if (!Hive.isAdapterRegistered(HiveAdapterType.flagData)) {
      Hive.registerAdapter(FlagDataAdapter());
    }

    _box = await Hive.openBox(_boxName);
  }

  @override
  Future<void> resync({required List<String> ids}) async {
    for (final id in ids) {
      if (!_box.containsKey(id)) {
        await _box.put(id, FlagData(id: id)..reset());
      }
    }
  }

  @override
  Future<void> reset() async {
    for (final flagData in _box.values) {
      flagData.reset();
      await flagData.save();
    }
  }

  // coverage:ignore-start
  /// DEBUG: Prints contents of db to the console
  @override
  void debugPrint() {
    for (final flagData in _box.values) {
      // ignore: avoid_print
      print(flagData);
    }
  }
  // coverage:ignore-end
}
