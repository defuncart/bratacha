import 'dart:math';

import 'package:bratacha/extensions/country_extensions.dart';
import 'package:bratacha/managers/level_manager.dart';
import 'package:bratacha/modules/country_database/country_database.dart';
import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:bratacha/services/game_service/i_game_service.dart';
import 'package:flutter/widgets.dart';

class GameService implements IGameService {
  GameService({
    required this.isHardDifficulty,
    required this.playerDataService,
    required int level,
    required LevelManager levelManager,
    @visibleForTesting Random? random,
  }) {
    final levelCountries = levelManager.countriesForLevel(level);
    _indicesCountriesForLevel = levelCountries
        .map(
          (country) => _countries.indexOf(country),
        )
        .toList(growable: false)
      ..shuffle(random);

    _numberRounds = levelCountries.length;
  }

  final List<Country> _countries = CountryService.countries;
  late List<int> _indicesCountriesForLevel;
  late int _numberRounds;
  final bool isHardDifficulty;
  final IPlayerDataService playerDataService;
  int _index = 0;
  List<int> _countriesDisplayed = [];
  List<int> _countriesDisplayedLastRound = [];
  final _answeredQuestions = <String, bool>{};

  int get _indexForCurrentQuestion => _indicesCountriesForLevel[_index];

  Country get _questionCountry => _countries[_indexForCurrentQuestion];

  @override
  bool get levelCompleted => _index >= _numberRounds;

  @override
  GameRound nextRound() {
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
      final randomIndex = _indicesCountriesForLevel[Random().nextInt(_indicesCountriesForLevel.length)];
      if (!_countriesDisplayed.contains(randomIndex) && !_countriesDisplayedLastRound.contains(randomIndex)) {
        _countriesDisplayed.remove(-1);
        _countriesDisplayed.add(randomIndex);
      }
    }

    _countriesDisplayed.shuffle();
    _countriesDisplayedLastRound = _countriesDisplayed;

    return (
      question: _questionCountry.localizedName,
      answers: _countriesDisplayed.map((index) => _countries[index].id).toList(),
    );
  }

  @override
  (String, String) answerWithId(String id) {
    final correct = _questionCountry.id == id;
    _answeredQuestions[_questionCountry.id] = correct;

    final questionCountryId = _questionCountry.id;

    if (++_index < _numberRounds) {
      // _nextRound();
    } else {
      // level completed, update progress
      for (final kvp in _answeredQuestions.entries) {
        final id = kvp.key;
        final correct = kvp.value;
        playerDataService.updateProgress(id: id, answeredCorrectly: correct);
      }
    }

    return (questionCountryId, CountryService.countryWithId(id).localizedName);
  }

  int _indexById(String id) => _countries.indexWhere((country) => country.id == id);
}
