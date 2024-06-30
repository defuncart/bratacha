abstract class IGameService {
  bool get levelCompleted;

  GameRound nextRound();

  bool answerWithId(String id);
}

typedef GameRound = ({
  String question,
  List<String> answers,
});
