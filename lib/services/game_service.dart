import 'dart:math';

import 'package:bratacha/extensions/country_extensions.dart';
import 'package:bratacha/managers/level_manager.dart';
import 'package:bratacha/modules/country_database/country_database.dart';
import 'package:meta/meta.dart';

class GameService {
  final List<Country> _countries = CountryService.countries;
  List<int> _indecesCountriesForLevel;
  int _numberRounds;
  final bool isHardDifficulty;
  int _index;
  List<int> _countriesDisplayed;
  List<int> _countriesDisplayedLastRound;

  GameService({
    @required this.isHardDifficulty,
    @required int level,
    @required LevelManager levelManager,
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
    _index = 0;
    _countriesDisplayedLastRound = [];
    _nextRound();
  }

  int get _indexForCurrentQuestion => _indecesCountriesForLevel[_index];

  Country get _questionCountry => _countries[_indexForCurrentQuestion];

  String get questionCountry => _questionCountry.localizedName;

  List<String> get answerCountries => _countriesDisplayed.map((index) => _countries[index].id).toList();

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
  }

  bool answerWithId(String id) {
    final correct = _questionCountry.id == id;
    if (++_index < _numberRounds) {
      _nextRound();
    }

    return correct;
  }

  int _indexById(String id) => _countries.indexWhere((country) => country.id == id);
}
