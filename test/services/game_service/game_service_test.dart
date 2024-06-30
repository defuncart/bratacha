import 'dart:async';
import 'dart:ui';

import 'package:bratacha/intl/country_localizations.dart';
import 'package:bratacha/managers/level_manager.dart';
import 'package:bratacha/modules/country_database/country_database.dart';
import 'package:bratacha/services/game_service/game_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  // ensure localizations are setup
  CountryLocalizations.load(const Locale('en'));

  group('$GameService', () {
    test('ensure service correctly works', () async {
      final gameService = GameService(
        isHardDifficulty: false,
        playerDataService: MockPlayerDataService(),
        level: 0,
        levelManager: _MockLevelManager(),
      );

      late List<StreamSubscription> subscriptions;
      String? questionCountry;
      List<String>? answerCountries;

      subscriptions = [
        gameService.questionCountry.listen((event) => questionCountry = event),
        gameService.answerCountries.listen((event) => answerCountries = event),
      ];

      gameService.initialize();

      await Future.delayed(const Duration(milliseconds: 50));

      expect(questionCountry, isNotNull);
      expect(answerCountries, isNotNull);
      expect(gameService.levelCompleted, isFalse);

      gameService.answerWithId('de');

      await Future.delayed(const Duration(milliseconds: 50));

      expect(questionCountry, isNotNull);
      expect(answerCountries, isNotNull);
      expect(gameService.levelCompleted, isFalse);

      gameService.answerWithId('pl');

      await Future.delayed(const Duration(milliseconds: 50));

      expect(questionCountry, isNotNull);
      expect(answerCountries, isNotNull);
      expect(gameService.levelCompleted, isFalse);

      for (final subscription in subscriptions) {
        await subscription.cancel();
      }
    });

    test('levelCompleted after all questions answered', () async {
      final numberRounds = _MockLevelManager().countriesForLevel(0).length;

      final gameService = GameService(
        isHardDifficulty: true,
        playerDataService: MockPlayerDataService(),
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
