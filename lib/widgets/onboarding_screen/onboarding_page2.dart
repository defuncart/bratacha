import 'dart:async';

import 'package:bratacha/extensions/country_extensions.dart';
import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/modules/country_database/country_database.dart';
import 'package:bratacha/services/game_service/i_game_service.dart';
import 'package:bratacha/widgets/common/panels/hard_difficulty_panel/hard_difficulty_cubit.dart';
import 'package:bratacha/widgets/common/panels/hard_difficulty_panel/hard_difficulty_panel.dart';
import 'package:bratacha/widgets/game_screen/answers_cubit.dart';
import 'package:bratacha/widgets/game_screen/question_answer_panel.dart';
import 'package:bratacha/widgets/game_screen/question_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameService = _MockGameService(context.bloc<HardDifficultyCubit>());
    return LayoutBuilder(
      builder: (_, constraints) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            children: [
              Center(
                child: Text(
                  AppLocalizations.onboardingPage2TextLabel1,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              SizedBox(height: 8),
              Text(
                AppLocalizations.onboardingPage2TextLabel2,
              ),
              HardDifficultyPanel(),
            ],
          ),
          SizedBox(
            width: constraints.maxWidth * 0.75,
            height: constraints.maxWidth * 0.75 * 1.25,
            child: MultiBlocProvider(
              providers: [
                BlocProvider<QuestionCubit>(
                  create: (_) => QuestionCubit(gameService: gameService),
                ),
                BlocProvider<AnswersCubit>(
                  create: (_) => AnswersCubit(gameService: gameService),
                ),
              ],
              child: QuestionAnswerPanel(),
            ),
          ),
          Center(
            child: Text(
              AppLocalizations.onboardingGeneralSettingLabel,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _MockGameService implements IGameService {
  final _answersEasy = ['de', 'us', 'gb', 'ie'];
  final _answersHard = ['my', 'us', 'cl', 'lr'];

  final _answersController = StreamController<List<String>>();

  _MockGameService(HardDifficultyCubit cubit) {
    _answersController.add(cubit.state ? _answersHard : _answersEasy);

    cubit.listen((isHardDifficulty) {
      _answersController.add(isHardDifficulty ? _answersHard : _answersEasy);
    });
  }

  @override
  Stream<List<String>> get answerCountries => _answersController.stream;

  @override
  Stream<String> get questionCountry async* {
    yield CountryService.countryWithId('us').localizedName;
  }

  @override
  bool get levelCompleted => false;

  @override
  bool answerWithId(String id) => false;

  @override
  Stream<int> get currentScore async* {
    yield 0;
  }
}
