import 'package:bratacha/localizations.dart';
import 'package:bratacha/widgets/common/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Bratacha'),
      ),
      body: SafeArea(
        child: ListView.separated(
          separatorBuilder: (_, __) => Divider(),
          itemCount: _flagIds.length,
          itemBuilder: (_, index) => ListTile(
            title: Flag(
              _flagIds[index],
              height: 100,
              width: 100,
            ),
          ),
        ),
      ),
    );
  }
}

const _flagIds = [
  'ad',
  'ae',
  'af',
  'ag',
  'al',
  'am',
  'ao',
  'ar',
  'at',
  'au',
  'az',
  'ba',
  'bb',
  'bd',
  'be',
  'bf',
  'bg',
  'bh',
  'bi',
  'bj',
  'bn',
  'bo',
  'br',
  'bs',
  'bt',
  'bw',
  'by',
  'bz',
  'ca',
  'cd',
  'cf',
  'cg',
  'ch',
  'ci',
  'cl',
  'cm',
  'cn',
  'co',
  'cr',
  'cu',
  'cv',
  'cy',
  'cz',
  'de',
  'dj',
  'dk',
  'dm',
  'do',
  'dz',
  'ec',
  'ee',
  'eg',
  'er',
  'es',
  'et',
  'fi',
  'fj',
  'fm',
  'fr',
  'ga',
  'gb',
  'gd',
  'ge',
  'gh',
  'gm',
  'gn',
  'gq',
  'gr',
  'gt',
  'gw',
  'gy',
  'hn',
  'hr',
  'ht',
  'hu',
  'id',
  'ie',
  'il',
  'in',
  'iq',
  'ir',
  'is',
  'it',
  'jm',
  'jo',
  'jp',
  'ke',
  'kg',
  'kh',
  'ki',
  'km',
  'kn',
  'kp',
  'kr',
  'kw',
  'kz',
  'la',
  'lb',
  'lc',
  'li',
  'lk',
  'lr',
  'ls',
  'lt',
  'lu',
  'lv',
  'ly',
  'ma',
  'mc',
  'md',
  'me',
  'mg',
  'mh',
  'mk',
  'ml',
  'mm',
  'mn',
  'mr',
  'mt',
  'mu',
  'mv',
  'mw',
  'mx',
  'my',
  'mz',
  'na',
  'ne',
  'ng',
  'ni',
  'nl',
  'no',
  'np',
  'nr',
  'nz',
  'om',
  'pa',
  'pe',
  'pg',
  'ph',
  'pk',
  'pl',
  'pt',
  'pw',
  'py',
  'qa',
  'ro',
  'rs',
  'ru',
  'rw',
  'sa',
  'sb',
  'sc',
  'sd',
  'se',
  'sg',
  'si',
  'sk',
  'sl',
  'sm',
  'sn',
  'so',
  'sr',
  'ss',
  'st',
  'sv',
  'sy',
  'sz',
  'td',
  'tg',
  'th',
  'tj',
  'tl',
  'tm',
  'tn',
  'to',
  'tr',
  'tt',
  'tv',
  'tz',
  'ua',
  'ug',
  'us',
  'uy',
  'uz',
  'vc',
  've',
  'vn',
  'vu',
  'ws',
  'ye',
  'za',
  'zm',
  'zw',
];
