import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bratacha/services/i_game_service.dart';
import 'package:bratacha/widgets/common/flag.dart';
import 'package:bratacha/widgets/game_screen/answers_cubit.dart';
import 'package:bratacha/widgets/game_screen/question_cubit.dart';
import 'package:bratacha/widgets/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// TODO widget is only compatible with portrait orientation
class QuestionAnswerPanel extends StatelessWidget {
  const QuestionAnswerPanel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) => Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: BlocBuilder<QuestionCubit, String>(
              builder: (_, question) => Center(
                child: AutoSizeText(
                  question,
                  maxLines: 3,
                  style: Theme.of(context).textTheme.headline3,
                  minFontSize: 18,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SizedBox(
            height: constraints.maxWidth,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: LayoutBuilder(
                builder: (_, constraints) => BlocBuilder<AnswersCubit, List<String>>(
                  builder: (_, answers) {
                    const padding = 16.0;
                    final size = (min(constraints.maxWidth, constraints.maxHeight) - padding) / 2.0;

                    return Wrap(
                      spacing: padding,
                      runSpacing: padding,
                      children: [
                        for (final id in answers)
                          GestureDetector(
                            child: Flag(
                              id,
                              width: size,
                              height: size,
                            ),
                            onTap: () {
                              final gameService = context.repository<IGameService>();
                              gameService.answerWithId(id);
                              if (gameService.levelCompleted) {
                                Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                              }
                            },
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
