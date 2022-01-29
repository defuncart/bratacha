import 'package:bloc_test/bloc_test.dart';
import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:bratacha/widgets/common/panels/hard_difficulty_panel/hard_difficulty_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('$HardDifficultyCubit', () {
    blocTest<HardDifficultyCubit, bool>(
      'emits [] when nothing is added',
      build: () => HardDifficultyCubit(_MockPlayerDataService()),
      expect: () => [],
    );

    blocTest<HardDifficultyCubit, bool>(
      'emits [isTrue] when toggled and IPlayerDataService.isHardDifficulty is initially false',
      build: () => HardDifficultyCubit(_MockPlayerDataService(isHardDifficulty: false)),
      act: (cubit) => cubit.toggle(),
      expect: () => [isTrue],
    );

    blocTest<HardDifficultyCubit, bool>(
      'emits [isTrue, isFalse] when toggled twice and IPlayerDataService.isHardDifficulty is initially false',
      build: () => HardDifficultyCubit(_MockPlayerDataService(isHardDifficulty: false)),
      act: (cubit) => cubit
        ..toggle()
        ..toggle(),
      expect: () => [isTrue, isFalse],
    );

    blocTest<HardDifficultyCubit, bool>(
      'emits [isFalse] when toggled and IPlayerDataService.isHardDifficulty is initially true',
      build: () => HardDifficultyCubit(_MockPlayerDataService(isHardDifficulty: true)),
      act: (cubit) => cubit.toggle(),
      expect: () => [isFalse],
    );

    blocTest<HardDifficultyCubit, bool>(
      'emits [isFalse, isTrue] when toggled twice and IPlayerDataService.isHardDifficulty is initially true',
      build: () => HardDifficultyCubit(_MockPlayerDataService(isHardDifficulty: true)),
      act: (cubit) => cubit
        ..toggle()
        ..toggle(),
      expect: () => [isFalse, isTrue],
    );
  });
}

class _MockPlayerDataService extends Mock implements IPlayerDataService {
  bool _isHardDifficulty;

  _MockPlayerDataService({bool isHardDifficulty = false}) : _isHardDifficulty = isHardDifficulty;

  @override
  bool get isHardDifficulty => _isHardDifficulty;

  @override
  set isHardDifficulty(bool value) => _isHardDifficulty = value;
}
