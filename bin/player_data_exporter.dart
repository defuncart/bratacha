import 'dart:io';

import 'package:bratacha/modules/country_database/country_database.dart';
import 'package:bratacha/modules/player_data/player_data.dart';
import 'package:hive/hive.dart';

void main() async {
  final dir = PlayerDataService.defaultAssetPath;
  final file = File(dir);
  final boxName = file?.path?.split('/')?.last?.split('.')?.first;
  assert(boxName != null);

  Hive.init(file.parent.path);
  Hive.registerAdapter(CountryDataAdapter());
  final box = await Hive.openBox(boxName);

  await box.put('langauge', 'en');
  await box.put('isHardDifficulty', false);
  await box.put('score', 0);

  final countriesData = <String, CountryData>{};
  for (final country in CountryService.countries) {
    countriesData[country.id] = CountryData(id: country.id)..reset();
  }

  await box.put('countriesData', countriesData);
}
