import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localizations.dart';
import 'package:flutter_test/flutter_test.dart';

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
}) =>
    MaterialApp(
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
