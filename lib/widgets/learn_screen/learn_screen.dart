import 'package:bratacha/extensions/country_extensions.dart';
import 'package:bratacha/modules/country_database/country_database.dart';
import 'package:bratacha/widgets/common/flag.dart';
import 'package:flutter/material.dart';

class LearnScreen extends StatelessWidget {
  static const routeName = 'LearnScreen';

  const LearnScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final countries = CountryService.countries;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView.separated(
          separatorBuilder: (_, __) => Divider(),
          itemCount: countries.length,
          itemBuilder: (_, index) => ListTile(
            leading: Flag(
              countries[index].id,
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
