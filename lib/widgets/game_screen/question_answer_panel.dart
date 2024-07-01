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
          builder: (_, state) => switch (state) {
                GameStateStartRound(:final question, :final answers) => _QuestionAnswerPanelContent(
                    question: question,
                    answers: answers,
                    canInteract: true,
                  ),
                GameStateEndRound(
                  :final question,
                  :final answers,
                  :final correctAnswer,
                  :final userAnswer,
                  :final userAnsweredLocalized,
                  :final answeredCorrectly,
                ) =>
                  _QuestionAnswerPanelContent(
                    question: question,
                    answers: answers,
                    canInteract: false,
                    correctAnswer: correctAnswer,
                    userAnswer: userAnswer,
                    userAnsweredLocalized: userAnsweredLocalized,
                    answeredCorrectly: answeredCorrectly,
                  ),
                GameStateEndGame() => const SizedBox.shrink(),
              }),
    );
  }
}

class _QuestionAnswerPanelContent extends StatelessWidget {
  final String question;
  final List<String> answers;
  final bool canInteract;
  final String? correctAnswer;
  final String? userAnswer;
  final String? userAnsweredLocalized;
  final bool? answeredCorrectly;

  const _QuestionAnswerPanelContent({
    required this.question,
    required this.answers,
    required this.canInteract,
    this.correctAnswer,
    this.userAnswer,
    this.userAnsweredLocalized,
    this.answeredCorrectly,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Center(
            child: AutoSizeText(
              question,
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
              children: answers.map((id) {
                final flag = Flag(
                  id,
                  size: size,
                );

                if (canInteract) {
                  return GestureDetector(
                    onTap: () {
                      final gameCubit = context.read<GameCubit>();
                      gameCubit.answerWithId(id);
                    },
                    child: flag,
                  );
                }

                final showCorrectIcon = id == correctAnswer && userAnswer == correctAnswer;
                final showIncorrectIcon = id == userAnswer && userAnswer != correctAnswer;

                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Opacity(
                      opacity: id == correctAnswer ? 1 : 0.4,
                      child: flag,
                    ),
                    if (showCorrectIcon)
                      _AnswerIcon(
                        isCorrect: true,
                        size: size * 0.25,
                      )
                    else if (showIncorrectIcon)
                      _AnswerIcon(
                        isCorrect: false,
                        size: size * 0.25,
                      ),
                    if (showIncorrectIcon)
                      Positioned(
                        bottom: 4,
                        child: Container(
                          constraints: BoxConstraints(maxWidth: size - 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            userAnsweredLocalized!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                  ],
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}

class _AnswerIcon extends StatelessWidget {
  const _AnswerIcon({
    required this.size,
    required this.isCorrect,
  });

  final double size;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCorrect ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.error,
      ),
      child: Icon(
        isCorrect ? Icons.check : Icons.close,
        size: size,
        color: Colors.white,
      ),
    );
  }
}
