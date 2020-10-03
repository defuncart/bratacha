import 'package:bratacha/modules/settings_database/settings_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubit extends Cubit<String> {
  final ISettingsDatabase _settingsDatabase;

  LanguageCubit(this._settingsDatabase) : super(_settingsDatabase.language);

  void setLanguage(String language) {
    _settingsDatabase.language = language;
    emit(language);
  }
}
