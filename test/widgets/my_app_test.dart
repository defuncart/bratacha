import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:bratacha/widgets/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  testWidgets('Ensure widget tree is correct', (tester) async {
    await tester.pumpWidget(
      RepositoryProvider<IPlayerDataService>(
        create: (_) => _MockPlayerDataService(),
        child: MyApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(MultiRepositoryProvider), findsOneWidget);
    expect(find.byType(MultiBlocProvider), findsOneWidget);
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}

class _MockPlayerDataService extends Mock implements IPlayerDataService {
  @override
  String get language => 'en';

  @override
  int get score => 0;
}
