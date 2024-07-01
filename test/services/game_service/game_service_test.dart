import 'dart:math';
import 'dart:ui';

import 'package:bratacha/intl/country_localizations.dart';
import 'package:bratacha/modules/country_database/country_database.dart';
import 'package:bratacha/services/game_service/game_service.dart';
import 'package:bratacha/services/game_service/i_game_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  // ensure localizations are setup
  CountryLocalizations.load(const Locale('en'));

  group('$GameService', () {
    const countries = ['de', 'ie', 'pl', 'fr', 'es', 'pt', 'gb', 'us'];

    late MockLevelManager mockLevelManager;

    setUp(() {
      mockLevelManager = MockLevelManager();
      when(() => mockLevelManager.countriesForLevel(any()))
          .thenReturn(countries.map((code) => CountryService.countryWithId(code)).toList());
    });

    test('ensure service correctly works', () async {
      final gameService = GameService(
        isHardDifficulty: false,
        playerDataService: MockPlayerDataService(),
        level: 0,
        levelManager: mockLevelManager,
        random: Random(3),
      );

      expect(gameService.levelCompleted, isFalse);
      expect(
        gameService.nextRound(),
        isA<GameRound>().having((round) => round.question, 'question', 'Germany'),
      );

      gameService.answerWithId('de');

      expect(gameService.levelCompleted, isFalse);
      expect(
        gameService.nextRound(),
        isA<GameRound>().having((round) => round.question, 'question', 'United Kingdom'),
      );

      gameService.answerWithId('gb');

      expect(gameService.levelCompleted, isFalse);
    });

    test('levelCompleted after all questions answered', () async {
      final numberRounds = countries.length;

      final gameService = GameService(
        isHardDifficulty: true,
        playerDataService: MockPlayerDataService(),
        level: 0,
        levelManager: mockLevelManager,
      );

      for (var i = 0; i < numberRounds; i++) {
        gameService.answerWithId('de');
        final levelCompleted = i == numberRounds - 1;
        expect(gameService.levelCompleted, levelCompleted);
      }
    });
  });
}
