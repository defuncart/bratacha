import 'dart:math';

import 'package:bratacha/extensions/country_extensions.dart';
import 'package:bratacha/managers/level_manager.dart';
import 'package:bratacha/modules/country_database/country_database.dart';
import 'package:meta/meta.dart';

class GameService {
  final List<Country> _countries;
  int _index;
  List<int> _countriesDisplayed;
  List<int> _countriesDisplayedLastRound;

  GameService({
    @required LevelManager levelManager,
    @required int level,
  }) : _countries = levelManager.countriesForLevel(level);

  void initialize() {
    _index = 0;
    _countriesDisplayedLastRound = [];
    _nextRound();
  }

  String get questionCountry => _questionCountry.localizedName;

  Country get _questionCountry => _countries[_index];

  List<String> get answerCountries => _countriesDisplayed.map((index) => _countries[index].id).toList();

  bool get levelCompleted => _index >= _countries.length;

  void _nextRound() {
    _countriesDisplayed = [_countries.indexOf(_questionCountry), -1, -1, -1];
    while (_countriesDisplayed.contains(-1)) {
      final randomIndex = Random().nextInt(_countries.length);
      if (!_countriesDisplayed.contains(randomIndex) && !_countriesDisplayedLastRound.contains(randomIndex)) {
        _countriesDisplayed.remove(-1);
        _countriesDisplayed.add(randomIndex);
      }
    }
    _countriesDisplayedLastRound = _countriesDisplayed;
    _countriesDisplayed.shuffle();
  }

  bool answerWithId(String id) {
    final correct = _questionCountry.id == id;
    if (++_index < _countries.length) {
      _nextRound();
    }

    return correct;
  }
}
