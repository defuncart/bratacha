import 'package:bratacha/extensions/country_extensions.dart';
import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/modules/country_database/country_database.dart';
import 'package:bratacha/widgets/common/panels/hard_difficulty_panel/hard_difficulty_cubit.dart';
import 'package:bratacha/widgets/common/panels/hard_difficulty_panel/hard_difficulty_panel.dart';
import 'package:bratacha/widgets/game_screen/game_cubit.dart';
import 'package:bratacha/widgets/game_screen/question_answer_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    final isHardDifficulty = context.watch<HardDifficultyCubit>().state;

    return LayoutBuilder(
      // unique key to trigger rebuilds
      key: Key('OnboardingPage2$isHardDifficulty'),
      builder: (_, constraints) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Center(
                child: Text(
                  context.l10n.onboardingPage2TextLabel1,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 16),
              const HardDifficultyPanel(),
            ],
          ),
          SizedBox(
            width: constraints.maxWidth * 0.75,
            height: constraints.maxWidth * 0.75 * 1.25,
            child: MultiBlocProvider(
              providers: [
                BlocProvider<GameCubit>(
                  create: (_) => _FakeGameCubit(isHardDifficulty: isHardDifficulty),
                ),
              ],
              child: const QuestionAnswerPanel(),
            ),
          ),
          Center(
            child: Text(
              context.l10n.onboardingGeneralSettingLabel,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _FakeGameCubit extends Cubit<GameState> implements GameCubit {
  static const _answersEasy = ['de', 'us', 'gb', 'ie'];
  static const _answersHard = ['my', 'us', 'cl', 'lr'];

  _FakeGameCubit({required bool isHardDifficulty})
      : super(GameStateStartRound(
          progress: 0,
          question: CountryService.countryWithId('us').localizedName,
          answers: isHardDifficulty ? _answersHard : _answersEasy,
        ));

  @override
  void initialize() {}

  @override
  void answerWithId(String id) {}
}
