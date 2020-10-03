import 'package:bratacha/country_localizations.dart';
import 'package:bratacha/localizations.dart';
import 'package:bratacha/widgets/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        const CountryLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizationsDelegate.supportedLocals,
      home: HomeScreen(),
    );
  }
}
