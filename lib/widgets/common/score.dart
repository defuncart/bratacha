import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  const Score({
    required this.score,
    required this.color,
    this.fontSize = 16.0,
    super.key,
  })  : assert(score >= 0),
        assert(fontSize >= 8);

  final int score;
  final Color color;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: color,
          size: fontSize * 1.5,
        ),
        const SizedBox(width: 2.0),
        Text(
          score.toString(),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: color,
                fontSize: fontSize,
              ),
        )
      ],
    );
  }
}
