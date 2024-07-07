import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HardDifficultyCubit extends Cubit<bool> {
  final IPlayerDataService _playerDataService;

  HardDifficultyCubit(this._playerDataService) : super(_playerDataService.isHardDifficulty);

  void toggle() {
    final newState = !state;
    _playerDataService.isHardDifficulty = newState;
    emit(newState);
  }
}
