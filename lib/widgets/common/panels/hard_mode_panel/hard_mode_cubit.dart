import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HardModeCubit extends Cubit<bool> {
  final IPlayerDataService _playerDataService;

  HardModeCubit(this._playerDataService) : super(_playerDataService.isHardMode);

  void toggle() {
    final newState = !state;
    _playerDataService.isHardMode = newState;
    emit(newState);
  }
}
