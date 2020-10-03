import 'package:bratacha/intl/country_localizations.dart';
import 'package:bratacha/modules/country_database/country_database.dart';

extension CountryExtensions on Country {
  String get localizedName => CountryLocalizations.getString(key);
}
