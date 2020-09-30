import 'dart:convert';
import 'dart:io';

void main() async {
  const outputDir = 'assets/flags/';
  const fileExtension = '.svg';

  for (final id in _flagIds) {
    print('Downloading $id...');
    final url = _urlForFlagId(id, fileExtension);

    try {
      final request = await HttpClient().getUrl(Uri.parse(url));
      final response = await request.close();
      response.transform(utf8.decoder).listen((contents) {
        final file = File('$outputDir$id$fileExtension');
        try {
          file.writeAsStringSync(contents);
        } catch (_) {
          print('Could not save $id. Aborting.');
          return;
        }
      });
    } catch (_) {
      print('Could not download $id. Aborting.');
      break;
    }
  }
}

String _urlForFlagId(String id, String fileExtension) {
  const baseUrl = 'https://raw.githubusercontent.com/jackiboy/flagpack/master/flags/1x1/';

  return '$baseUrl$id$fileExtension';
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
