import 'package:bloc_test/bloc_test.dart';
import 'package:bratacha/intl/generated/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

extension WidgetTesterExtension on WidgetTester {
  void setSize(Size size) {
    view.physicalSize = size;
    view.devicePixelRatio = 1.0;
    addTearDown(() {
      view.resetPhysicalSize();
      view.resetDevicePixelRatio();
    });
  }
}

Widget wrapWithMaterialApp(Widget child) => MaterialApp(
  localizationsDelegates: const [
    AppLocalizations.delegate,
  ],
  locale: const Locale('en'),
  supportedLocales: const [Locale('en')],
  home: child,
);

Widget wrapWithMaterialAppGeneratedRoute({
  required Widget child,
  required Object? arguments,
}) => MaterialApp(
  localizationsDelegates: const [
    AppLocalizations.delegate,
  ],
  locale: const Locale('en'),
  supportedLocales: const [Locale('en')],
  onGenerateRoute: (settings) => MaterialPageRoute(
    builder: (context) => child,
    settings: RouteSettings(arguments: arguments),
  ),
);

// ignore: avoid_types_as_parameter_names
void whenState<State>(
  BlocBase<State> bloc,
  State state,
) {
  whenListen(bloc, Stream.value(state));
  when(() => bloc.state).thenReturn(state);
}
