abstract class IGameService {
  Stream<String> get questionCountry;

  Stream<List<String>> get answerCountries;

  bool get levelCompleted;

  bool answerWithId(String id);
}
