import 'package:bloc_test/bloc_test.dart';
import 'package:bratacha/widgets/common/panels/hard_difficulty_panel/hard_difficulty_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  group('$HardDifficultyCubit', () {
    late MockPlayerDataService mockPlayerDataService;

    setUp(() {
      mockPlayerDataService = MockPlayerDataService();
    });

    blocTest<HardDifficultyCubit, bool>(
      'emits [] when nothing is added',
      setUp: () {
        when(() => mockPlayerDataService.isHardDifficulty).thenReturn(false);
      },
      build: () => HardDifficultyCubit(mockPlayerDataService),
      expect: () => [],
    );

    blocTest<HardDifficultyCubit, bool>(
      'emits [isTrue] when toggled and IPlayerDataService.isHardDifficulty is initially false',
      setUp: () {
        when(() => mockPlayerDataService.isHardDifficulty).thenReturn(false);
      },
      build: () => HardDifficultyCubit(mockPlayerDataService),
      act: (cubit) => cubit.toggle(),
      expect: () => [isTrue],
    );

    blocTest<HardDifficultyCubit, bool>(
      'emits [isTrue, isFalse] when toggled twice and IPlayerDataService.isHardDifficulty is initially false',
      setUp: () {
        when(() => mockPlayerDataService.isHardDifficulty).thenReturn(false);
      },
      build: () => HardDifficultyCubit(mockPlayerDataService),
      act: (cubit) => cubit
        ..toggle()
        ..toggle(),
      expect: () => [isTrue, isFalse],
    );

    blocTest<HardDifficultyCubit, bool>(
      'emits [isFalse] when toggled and IPlayerDataService.isHardDifficulty is initially true',
      setUp: () {
        when(() => mockPlayerDataService.isHardDifficulty).thenReturn(true);
      },
      build: () => HardDifficultyCubit(mockPlayerDataService),
      act: (cubit) => cubit.toggle(),
      expect: () => [isFalse],
    );

    blocTest<HardDifficultyCubit, bool>(
      'emits [isFalse, isTrue] when toggled twice and IPlayerDataService.isHardDifficulty is initially true',
      setUp: () {
        when(() => mockPlayerDataService.isHardDifficulty).thenReturn(true);
      },
      build: () => HardDifficultyCubit(mockPlayerDataService),
      act: (cubit) => cubit
        ..toggle()
        ..toggle(),
      expect: () => [isFalse, isTrue],
    );
  });
}
