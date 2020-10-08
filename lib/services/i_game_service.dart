abstract class IGameService {
  Stream<String> get questionCountry;

  Stream<List<String>> get answerCountries;

  Stream<int> get currentScore;

  bool get levelCompleted;

  bool answerWithId(String id);
}
