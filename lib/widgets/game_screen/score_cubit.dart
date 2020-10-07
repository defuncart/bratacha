import 'dart:async';

import 'package:bratacha/services/i_game_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class ScoreCubit extends Cubit<int> {
  StreamSubscription<int> _subscription;

  ScoreCubit({@required IGameService gameService}) : super(0) {
    _subscription = gameService.currentScore.listen((event) => emit(event));
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    await super.close();
  }
}
