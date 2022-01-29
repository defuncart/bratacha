import 'dart:async';
import 'dart:ui';

import 'package:bratacha/intl/country_localizations.dart';
import 'package:bratacha/managers/level_manager.dart';
import 'package:bratacha/modules/country_database/country_database.dart';
import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:bratacha/services/game_service/game_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  // ensure localizations are setup
  CountryLocalizations.load(Locale('en'));

  group('$GameService', () {
    test('ensure service correctly works', () async {
      final gameService = GameService(
        isHardDifficulty: false,
        playerDataService: _MockPlayerDataService(),
        level: 0,
        levelManager: _MockLevelManager(),
      );

      late List<StreamSubscription> subscriptions;
      String? questionCountry;
      List<String>? answerCountries;
      int? currentScore;

      subscriptions = [
        gameService.questionCountry.listen((event) => questionCountry = event),
        gameService.answerCountries.listen((event) => answerCountries = event),
        gameService.currentScore.listen((event) => currentScore = event),
      ];

      gameService.initialize();

      await Future.delayed(Duration(milliseconds: 50));

      expect(questionCountry, isNotNull);
      expect(answerCountries, isNotNull);
      expect(currentScore, 0);
      expect(gameService.levelCompleted, isFalse);

      gameService.answerWithId('de');

      await Future.delayed(Duration(milliseconds: 50));

      expect(questionCountry, isNotNull);
      expect(answerCountries, isNotNull);
      expect(currentScore, 1);
      expect(gameService.levelCompleted, isFalse);

      gameService.answerWithId('pl');

      await Future.delayed(Duration(milliseconds: 50));

      expect(questionCountry, isNotNull);
      expect(answerCountries, isNotNull);
      expect(currentScore, 1);
      expect(gameService.levelCompleted, isFalse);

      for (final subscription in subscriptions) {
        await subscription.cancel();
      }
    });

    test('isHardDifficulty doubles score', () async {
      final gameService = GameService(
        isHardDifficulty: true,
        playerDataService: _MockPlayerDataService(),
        level: 0,
        levelManager: _MockLevelManager(),
      );

      int? currentScore;
      final subscriptions = [
        gameService.currentScore.listen((event) => currentScore = event),
      ];

      gameService.initialize();

      await Future.delayed(Duration(milliseconds: 50));

      expect(currentScore, 0);

      gameService.answerWithId('de');

      await Future.delayed(Duration(milliseconds: 50));

      expect(currentScore, 2);

      for (final subscription in subscriptions) {
        await subscription.cancel();
      }
    });

    test('levelCompleted after all questions answered', () async {
      final numberRounds = _MockLevelManager().countriesForLevel(0).length;

      final gameService = GameService(
        isHardDifficulty: true,
        playerDataService: _MockPlayerDataService(),
        level: 0,
        levelManager: _MockLevelManager(),
      )..initialize();

      for (var i = 0; i < numberRounds; i++) {
        gameService.answerWithId('bla');
        final levelCompleted = i == numberRounds - 1;
        expect(gameService.levelCompleted, levelCompleted);
      }
    });
  });
}

class _MockPlayerDataService extends Mock implements IPlayerDataService {
  @override
  int get score => 0;
}

class _MockLevelManager extends Mock implements LevelManager {
  @override
  List<Country> countriesForLevel(int level) => [
        CountryService.countryWithId('de'),
        CountryService.countryWithId('ie'),
        CountryService.countryWithId('pl'),
        CountryService.countryWithId('fr'),
        CountryService.countryWithId('es'),
        CountryService.countryWithId('pt'),
        CountryService.countryWithId('gb'),
        CountryService.countryWithId('us'),
      ];
}
