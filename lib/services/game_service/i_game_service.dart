abstract class IGameService {
  bool get levelCompleted;

  GameRound nextRound();

  (String, String, double) answerWithId(String id);
}

typedef GameRound = ({
  double progress,
  String question,
  List<String> answers,
});
