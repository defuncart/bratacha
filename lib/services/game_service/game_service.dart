import 'dart:async';
import 'dart:math';

import 'package:bratacha/extensions/country_extensions.dart';
import 'package:bratacha/managers/level_manager.dart';
import 'package:bratacha/modules/country_database/country_database.dart';
import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:bratacha/services/game_service/i_game_service.dart';

class GameService implements IGameService {
  final List<Country> _countries = CountryService.countries;
  List<int> _indecesCountriesForLevel = [];
  int _numberRounds = -1;
  final bool isHardDifficulty;
  final IPlayerDataService playerDataService;
  int _score = 0;
  int _index = -1;
  List<int> _countriesDisplayed = [];
  List<int> _countriesDisplayedLastRound = [];

  GameService({
    required this.isHardDifficulty,
    required this.playerDataService,
    required int level,
    required LevelManager levelManager,
  }) {
    final levelCountries = levelManager.countriesForLevel(level);
    final indeces = <int>[];
    for (final country in levelCountries) {
      indeces.add(_countries.indexOf(country));
    }
    _indecesCountriesForLevel = List.unmodifiable(indeces);

    _numberRounds = levelCountries.length;
  }

  void initialize() {
    _score = 0;
    _scoreController.add(_score);

    _index = 0;
    _countriesDisplayedLastRound = [];
    _nextRound();
  }

  int get _indexForCurrentQuestion => _indecesCountriesForLevel[_index];

  Country get _questionCountry => _countries[_indexForCurrentQuestion];

  final _questionController = StreamController<String>();

  @override
  Stream<String> get questionCountry => _questionController.stream;

  final _answersController = StreamController<List<String>>();

  @override
  Stream<List<String>> get answerCountries => _answersController.stream;

  final _scoreController = StreamController<int>();

  @override
  Stream<int> get currentScore => _scoreController.stream;

  @override
  bool get levelCompleted => _index >= _numberRounds;

  void _nextRound() {
    _countriesDisplayed = [_indexForCurrentQuestion, -1, -1, -1];

    // if on hard difficult, add up to three similar flags
    if (isHardDifficulty) {
      final similarFlags = List<String>.from(_questionCountry.similarFlags);
      similarFlags.shuffle();
      for (final similarFlag in similarFlags) {
        if (_countriesDisplayed.contains(-1)) {
          _countriesDisplayed.remove(-1);
          _countriesDisplayed.add(_indexById(similarFlag));
        }
      }
    }

    // TODO: When easy mode, this assumes that the number of countries is at least 8
    // randomly select flags from this level which weren't shown last round
    while (_countriesDisplayed.contains(-1)) {
      final randomIndex = _indecesCountriesForLevel[Random().nextInt(_indecesCountriesForLevel.length)];
      if (!_countriesDisplayed.contains(randomIndex) && !_countriesDisplayedLastRound.contains(randomIndex)) {
        _countriesDisplayed.remove(-1);
        _countriesDisplayed.add(randomIndex);
      }
    }

    _countriesDisplayed.shuffle();
    _countriesDisplayedLastRound = _countriesDisplayed;

    _questionController.add(_questionCountry.localizedName);
    _answersController.add(_countriesDisplayed.map((index) => _countries[index].id).toList());
  }

  @override
  bool answerWithId(String id) {
    final correct = _questionCountry.id == id;
    if (correct) {
      _score += (isHardDifficulty ? 2 : 1);
      _scoreController.add(_score);
    }
    playerDataService.updateProgress(id: id, answeredCorrectly: correct);

    if (++_index < _numberRounds) {
      _nextRound();
    } else {
      // only update score on level completion
      playerDataService.score += _score;
    }

    return correct;
  }

  int _indexById(String id) => _countries.indexWhere((country) => country.id == id);
}
