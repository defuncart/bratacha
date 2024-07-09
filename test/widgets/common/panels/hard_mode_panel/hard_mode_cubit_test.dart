import 'package:bloc_test/bloc_test.dart';
import 'package:bratacha/widgets/common/panels/hard_mode_panel/hard_mode_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';

void main() {
  group('$HardModeCubit', () {
    late MockPlayerDataService mockPlayerDataService;

    setUp(() {
      mockPlayerDataService = MockPlayerDataService();
    });

    blocTest<HardModeCubit, bool>(
      'emits [] when nothing is added',
      setUp: () {
        when(() => mockPlayerDataService.isHardMode).thenReturn(false);
      },
      build: () => HardModeCubit(mockPlayerDataService),
      expect: () => [],
    );

    blocTest<HardModeCubit, bool>(
      'emits [isTrue] when toggled and IPlayerDataService.isHardMode is initially false',
      setUp: () {
        when(() => mockPlayerDataService.isHardMode).thenReturn(false);
      },
      build: () => HardModeCubit(mockPlayerDataService),
      act: (cubit) => cubit.toggle(),
      expect: () => [isTrue],
    );

    blocTest<HardModeCubit, bool>(
      'emits [isTrue, isFalse] when toggled twice and IPlayerDataService.isHardMode is initially false',
      setUp: () {
        when(() => mockPlayerDataService.isHardMode).thenReturn(false);
      },
      build: () => HardModeCubit(mockPlayerDataService),
      act: (cubit) => cubit
        ..toggle()
        ..toggle(),
      expect: () => [isTrue, isFalse],
    );

    blocTest<HardModeCubit, bool>(
      'emits [isFalse] when toggled and IPlayerDataService.isHardMode is initially true',
      setUp: () {
        when(() => mockPlayerDataService.isHardMode).thenReturn(true);
      },
      build: () => HardModeCubit(mockPlayerDataService),
      act: (cubit) => cubit.toggle(),
      expect: () => [isFalse],
    );

    blocTest<HardModeCubit, bool>(
      'emits [isFalse, isTrue] when toggled twice and IPlayerDataService.isHardMode is initially true',
      setUp: () {
        when(() => mockPlayerDataService.isHardMode).thenReturn(true);
      },
      build: () => HardModeCubit(mockPlayerDataService),
      act: (cubit) => cubit
        ..toggle()
        ..toggle(),
      expect: () => [isFalse, isTrue],
    );
  });
}
