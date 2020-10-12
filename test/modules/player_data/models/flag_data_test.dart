import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Ensure FlagData is correctly constructed', () {
    final flagData = FlagData(id: 'de');
    expect(flagData, isNotNull);
    expect(flagData.id, isNotNull);
    expect(flagData.id, 'de');
    expect(flagData.attempts, isNull);
    expect(flagData.timesCorrect, isNull);
    expect(flagData.percentageCorrect, isNull);
    expect(flagData.toString(), isNotNull);
  });

  test('Ensure FlagData is correctly constructed and initialized', () {
    final flagData = FlagData(id: 'de')..reset();
    expect(flagData, isNotNull);
    expect(flagData.id, isNotNull);
    expect(flagData.id, 'de');
    expect(flagData.attempts, isNotNull);
    expect(flagData.attempts, 0);
    expect(flagData.timesCorrect, isNotNull);
    expect(flagData.timesCorrect, 0);
    expect(flagData.percentageCorrect, isNotNull);
    expect(flagData.percentageCorrect, 0);
    expect(flagData.toString(), isNotNull);
  });

  test('FlagData answered incorrectly, ensure variables are updated', () {
    final flagData = FlagData(id: 'de')..reset();
    expect(flagData.attempts, 0);
    expect(flagData.timesCorrect, 0);
    expect(flagData.percentageCorrect, 0);

    flagData.updateProgress(answeredCorrectly: false);
    expect(flagData.attempts, 1);
    expect(flagData.timesCorrect, 0);
    expect(flagData.percentageCorrect, 0);
  });

  test('FlagData answered correctly, ensure variables are updated', () {
    final flagData = FlagData(id: 'de')..reset();
    expect(flagData.attempts, 0);
    expect(flagData.timesCorrect, 0);
    expect(flagData.percentageCorrect, 0);

    flagData.updateProgress(answeredCorrectly: true);
    expect(flagData.attempts, 1);
    expect(flagData.timesCorrect, 1);
    expect(flagData.percentageCorrect, 1);
  });

  test('FlagData percentageCorrect', () {
    final flagData = FlagData(id: 'de')..reset();
    expect(flagData.attempts, 0);
    expect(flagData.timesCorrect, 0);
    expect(flagData.percentageCorrect, 0);

    flagData.updateProgress(answeredCorrectly: true);
    flagData.updateProgress(answeredCorrectly: false);
    flagData.updateProgress(answeredCorrectly: true);
    expect(flagData.attempts, 3);
    expect(flagData.timesCorrect, 2);
    expect(flagData.percentageCorrect, 2 / 3);
  });
}
