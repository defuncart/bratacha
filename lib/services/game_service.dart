import 'dart:math';

import 'package:bratacha/managers/level_manager.dart';
import 'package:bratacha/modules/country_database/country_database.dart';
import 'package:meta/meta.dart';

class GameService {
  final List<Country> _countries;
  int _index;
  List<int> _countriesDisplayed;

  GameService({
    @required LevelManager levelManager,
    @required int level,
  }) : _countries = levelManager.countriesForLevel(level);

  void initialize() {
    _index = 0;
    _nextRound();
  }

  Country get questionCountry => _countries[_index];

  List<String> get answerCountries => _countriesDisplayed.map((index) => _countries[index].key).toList();

  bool get levelCompleted => _index >= _countries.length;

  void _nextRound() {
    _countriesDisplayed = [_countries.indexOf(questionCountry), -1, -1, -1];
    while (_countriesDisplayed.contains(-1)) {
      final randomIndex = Random().nextInt(_countries.length);
      if (!_countriesDisplayed.contains(randomIndex)) {
        _countriesDisplayed.remove(-1);
        _countriesDisplayed.add(randomIndex);
      }
    }
    _countriesDisplayed.shuffle();
  }

  bool answerWithId(String id) {
    final correct = questionCountry.key == id;
    if (++_index < _countries.length) {
      _nextRound();
    }

    return correct;
  }
}
