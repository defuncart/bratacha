import 'package:bratacha/extensions/country_extensions.dart';
import 'package:bratacha/modules/country_database/country_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchFlagsCubit extends Cubit<List<Country>> {
  final String _language;

  SearchFlagsCubit(this._language) : super([]) {
    _search();
  }

  var _searchTerm = '';

  void update(String searchTerm) {
    _searchTerm = searchTerm.trim().toLowerCase();
    _search();
  }

  void _search() {
    final countries = List<Country>.from(
      _searchTerm.isEmpty
          ? CountryService.countries
          : CountryService.countries
              .where((country) => country.localizedName.toLowerCase().contains(_searchTerm))
              .toList(),
    );
    countries.sort((a, b) => a.sortTerm(_language).compareTo(b.sortTerm(_language)));

    emit(countries);
  }
}

extension on Country {
  String sortTerm(String language) => switch (language) {
        'en' => localizedName.replaceAll('The ', ''),
        'be' => localizedName.toLowerCase().replaceAll('і', 'й'),
        'cy' => localizedName.replaceAll('Yr ', ''),
        'ga' => localizedName.replaceAll('An t', '').replaceAll('An ', '').normalizeGA,
        _ => localizedName,
      };
}

extension on String {
  String get normalizeGA => replaceAll('É', 'E').replaceAll('Í', 'I').replaceAll('Ó', 'O').replaceAll('Ú', 'U');
}
