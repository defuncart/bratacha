import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubit extends Cubit<String> {
  final IPlayerDataService _playerDataService;

  LanguageCubit(this._playerDataService) : super(_playerDataService.language);

  void setLanguage(String language) {
    _playerDataService.language = language;
    emit(_playerDataService.language);
  }
}
