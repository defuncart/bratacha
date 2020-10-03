import 'package:bratacha/modules/settings_database/settings_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DarkModeCubit extends Cubit<bool> {
  final ISettingsDatabase _settingsDatabase;

  DarkModeCubit(this._settingsDatabase) : super(_settingsDatabase.isDarkMode);

  void toggle() {
    _settingsDatabase.isDarkMode = !_settingsDatabase.isDarkMode;
    emit(_settingsDatabase.isDarkMode);
  }
}
