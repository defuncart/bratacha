import 'package:bratacha/modules/settings_database/settings_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HardDifficultyCubit extends Cubit<bool> {
  final ISettingsDatabase _settingsDatabase;

  HardDifficultyCubit(this._settingsDatabase) : super(_settingsDatabase.isHardDifficulty);

  void toggle() {
    _settingsDatabase.isHardDifficulty = !_settingsDatabase.isHardDifficulty;
    emit(_settingsDatabase.isHardDifficulty);
  }
}
