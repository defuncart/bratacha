abstract class IGameService {
  bool get levelCompleted;

  GameRound nextRound();

  (String, String) answerWithId(String id);
}

typedef GameRound = ({
  String question,
  List<String> answers,
});
