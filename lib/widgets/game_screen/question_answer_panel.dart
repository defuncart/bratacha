import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bratacha/widgets/common/flag.dart';
import 'package:bratacha/widgets/game_screen/game_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// TODO widget is only compatible with portrait orientation
class QuestionAnswerPanel extends StatelessWidget {
  const QuestionAnswerPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: BlocBuilder<GameCubit, GameState>(
        builder: (_, state) => Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: AutoSizeText(
                  state.question,
                  maxLines: 3,
                  style: Theme.of(context).textTheme.displaySmall,
                  minFontSize: 18,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            LayoutBuilder(
              builder: (_, constraints) {
                const padding = 16.0;
                final size = (min(constraints.maxWidth, constraints.maxHeight) - padding) / 2.0;

                return Wrap(
                  spacing: padding,
                  runSpacing: padding,
                  children: [
                    for (final id in state.answers)
                      GestureDetector(
                        child: Flag(
                          id,
                          size: size,
                        ),
                        onTap: () {
                          final gameCubit = context.read<GameCubit>();
                          gameCubit.answerWithId(id);
                        },
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
