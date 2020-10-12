import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  final int score;
  final Color color;
  final double fontSize;

  const Score({
    Key key,
    @required this.score,
    @required this.color,
    this.fontSize = 16.0,
  })  : assert(score != null && score >= 0),
        assert(color != null),
        assert(fontSize != null && fontSize >= 8),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          color: color,
          size: fontSize * 1.5,
        ),
        SizedBox(width: 2.0),
        Text(
          score.toString(),
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: color,
                fontSize: fontSize,
              ),
        )
      ],
    );
  }
}
