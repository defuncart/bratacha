abstract class IGameService {
  GameRound nextRound();

  (String, String, double, GameResult?) answerWithId(String id);
}

typedef GameRound = ({
  double progress,
  String question,
  List<String> answers,
  GameResult? result,
});

typedef GameResult = ({
  double levelProgressBefore,
  double levelProgressAfter,
  int numberRounds,
  int correctAnswers,
  List<String> incorrectIds,
});
