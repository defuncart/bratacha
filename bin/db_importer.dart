import 'dart:convert';
import 'dart:io';

import 'package:bratacha/modules/country_database/country_database.dart' show Continent;
import 'package:meta/meta.dart';

void main() async {
  // countries
  const countriesDBFilepath = 'assets_dev/database/countries.json';

  var importFile = File(countriesDBFilepath);
  if (!importFile.existsSync()) {
    print('File $countriesDBFilepath does not exist. Aborting.');
    return;
  }

  var data = importFile.readAsStringSync();
  final countries = (json.decode(data) as List).map((model) => _CountryImportModel.fromJson(model)).toList();

  // country_service
  const countriesConfigOutputPath = 'lib/modules/country_database/src/services/country_service.g.dart';

  final sb = StringBuffer();
  sb.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
  sb.writeln('part of \'country_service.dart\';');
  sb.writeln();
  sb.writeln('const _countries = [');
  for (final country in countries) {
    sb.writeln('\tCountry(key: \'${country.key}\', continent: ${country.continent.toString()}),');
  }
  sb.writeln('];');

  var outputFile = File(countriesConfigOutputPath);
  if (!outputFile.existsSync()) {
    outputFile.createSync(recursive: true);
  }
  outputFile.writeAsStringSync(sb.toString());
  await Process.run('dartfmt', ['-w', countriesConfigOutputPath]);

  // loca
  const locaOutputPath = 'lib/modules/country_database/src/country_localizations.g.dart';
  final locales = ['en', 'by', 'cy', 'ga'];
  final mapLocalesIndeces = {
    'en': 0,
    'by': 1,
    'cy': 2,
    'ga': 3,
  };

  sb.clear();
  sb.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
  sb.writeln('part of \'country_localizations.dart\';');
  sb.writeln();
  sb.writeln('mixin _\$CountryLocalizations {');
  for (final locale in locales) {
    final index = mapLocalesIndeces[locale];
    sb.writeln('\tstatic const _$locale = {');
    for (final country in countries) {
      final countryName = country.names[index].replaceAll('\'', '\\\'');
      sb.writeln('\t\t\'${country.key}\': \'$countryName\',');
    }
    sb.writeln('\t};\n');
  }
  sb.writeln('\tstatic final _locales = {');
  for (final locale in locales) {
    sb.writeln('\t\t\'$locale\': _$locale,');
  }
  sb.writeln('\t};');
  sb.writeln('}');
  sb.writeln();
  sb.writeln('class _\$CountryLocalizationsDelegate {');
  sb.writeln('\tstatic final _supportedLocales = {');
  for (final locale in locales) {
    sb.writeln('\t\tLocale(\'$locale\'),');
  }
  sb.writeln('\t};');
  sb.writeln('}');

  outputFile = File(locaOutputPath);
  if (!outputFile.existsSync()) {
    outputFile.createSync(recursive: true);
  }
  outputFile.writeAsStringSync(sb.toString());
  await Process.run('dartfmt', ['-w', locaOutputPath]);

  // levels
  const levelsDBFilepath = 'assets_dev/database/levels.json';

  importFile = File(levelsDBFilepath);
  if (!importFile.existsSync()) {
    print('File $levelsDBFilepath does not exist. Aborting.');
    return;
  }

  data = importFile.readAsStringSync();
  final levels = (json.decode(data) as List).map((model) => _LevelImportModel.fromJson(model)).toList();

  // level_service
  const levelsServiceOutputPath = 'lib/modules/level_database/src/services/level_service.g.dart';

  sb.clear();
  sb.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
  sb.writeln('part of \'level_service.dart\';');
  sb.writeln();
  sb.writeln('const _levels = [');
  for (final level in levels) {
    sb.writeln('\t${_listToCodeString(level.countries)},');
  }
  sb.writeln('];');

  outputFile = File(levelsServiceOutputPath);
  if (!outputFile.existsSync()) {
    outputFile.createSync(recursive: true);
  }
  outputFile.writeAsStringSync(sb.toString());
  await Process.run('dartfmt', ['-w', levelsServiceOutputPath]);
}

class _CountryImportModel {
  final String key;

  final Continent continent;

  final List<String> names;

  const _CountryImportModel({
    this.key,
    this.continent,
    this.names,
  });

  factory _CountryImportModel.fromJson(Map<String, dynamic> json) => _CountryImportModel(
        key: json['key'],
        continent: Continent.values[json['continent']],
        names: List<String>.from(json['names'].map((item) => item)),
      );
}

String _listToCodeString(List<dynamic> list) {
  final sb = StringBuffer();
  sb.write('[');
  for (final item in list) {
    sb.write('\'${item.toString()}\',');
  }
  sb.write(']');
  return sb.toString();
}

class _LevelImportModel {
  final String key;
  final List<String> countries;

  const _LevelImportModel({
    @required this.key,
    @required this.countries,
  })  : assert(key != null),
        assert(countries != null);

  factory _LevelImportModel.fromJson(Map<String, dynamic> json) => _LevelImportModel(
        key: json['key'],
        countries: List<String>.from(json['countries'].map((item) => item)),
      );
}
