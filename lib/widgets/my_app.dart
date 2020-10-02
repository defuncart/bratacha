import 'package:bratacha/extensions/country_extensions.dart';
import 'package:bratacha/localizations.dart';
import 'package:bratacha/modules/country_database/country_database.dart';
import 'package:bratacha/widgets/common/flag.dart';
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
      home: _HomeScreen(),
    );
  }
}

class _HomeScreen extends StatelessWidget {
  const _HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final countries = CountryService.countries;
    return Scaffold(
      appBar: AppBar(
        title: Text('Bratacha'),
      ),
      body: SafeArea(
        child: ListView.separated(
          separatorBuilder: (_, __) => Divider(),
          itemCount: countries.length,
          itemBuilder: (_, index) => ListTile(
            leading: Flag(
              countries[index].key,
              height: 100,
              width: 100,
            ),
            title: Text(countries[index].localizedName),
          ),
        ),
      ),
    );
  }
}
