import 'package:bloc_test/bloc_test.dart';
import 'package:bratacha/modules/settings_database/settings_database.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/hard_difficulty_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('HardDifficultyCubit', () {
    blocTest(
      'emits [] when nothing is added',
      build: () => HardDifficultyCubit(_MockSettingsDatabase()),
      expect: [],
    );

    blocTest(
      'emits [isTrue] when toggled and ISettingsDatabase.isHardDifficulty is initially false',
      build: () => HardDifficultyCubit(_MockSettingsDatabase(isHardDifficulty: false)),
      act: (cubit) => cubit.toggle(),
      expect: [isTrue],
    );

    blocTest(
      'emits [isTrue, isFalse] when toggled twice and ISettingsDatabase.isHardDifficulty is initially false',
      build: () => HardDifficultyCubit(_MockSettingsDatabase(isHardDifficulty: false)),
      act: (cubit) => cubit..toggle()..toggle(),
      expect: [isTrue, isFalse],
    );

    blocTest(
      'emits [isFalse] when toggled and ISettingsDatabase.isHardDifficulty is initially true',
      build: () => HardDifficultyCubit(_MockSettingsDatabase(isHardDifficulty: true)),
      act: (cubit) => cubit.toggle(),
      expect: [isFalse],
    );

    blocTest(
      'emits [isFalse, isTrue] when toggled twice and ISettingsDatabase.isHardDifficulty is initially true',
      build: () => HardDifficultyCubit(_MockSettingsDatabase(isHardDifficulty: true)),
      act: (cubit) => cubit..toggle()..toggle(),
      expect: [isFalse, isTrue],
    );
  });
}

class _MockSettingsDatabase extends Mock implements ISettingsDatabase {
  bool _isHardDifficulty;

  _MockSettingsDatabase({bool isHardDifficulty = false}) : _isHardDifficulty = isHardDifficulty;

  @override
  bool get isHardDifficulty => _isHardDifficulty;

  @override
  set isHardDifficulty(bool value) => _isHardDifficulty = value;
}
