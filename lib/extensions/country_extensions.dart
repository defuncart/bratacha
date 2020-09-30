import 'package:bratacha/localizations.dart';
import 'package:bratacha/modules/country_database/country_database.dart';

extension CountryExtensions on Country {
  String get localizedName => AppLocalizations.getString('${key}Country');
}
