import 'dart:async';

import 'package:bratacha/services/game_service/i_game_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class AnswersCubit extends Cubit<List<String>> {
  StreamSubscription<List<String>> _subscription;

  AnswersCubit({@required IGameService gameService}) : super([]) {
    _subscription = gameService.answerCountries.listen((event) => emit(event));
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    await super.close();
  }
}
