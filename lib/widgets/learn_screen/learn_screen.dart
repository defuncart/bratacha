import 'package:bratacha/extensions/country_extensions.dart';
import 'package:bratacha/modules/country_database/country_database.dart';
import 'package:bratacha/widgets/common/flag.dart';
import 'package:flutter/material.dart';

class LearnScreen extends StatelessWidget {
  static const routeName = 'LearnScreen';

  const LearnScreen({Key? key}) : super(key: key);

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
              size: 100,
            ),
            // TODO: show only in debug mode
            trailing: _SimilarFlagsList(
              similarFlags: countries[index].similarFlags,
            ),
            title: Text(countries[index].localizedName),
          ),
        ),
      ),
    );
  }
}

class _SimilarFlagsList extends StatelessWidget {
  const _SimilarFlagsList({
    required this.similarFlags,
    Key? key,
  }) : super(key: key);

  final List<String> similarFlags;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (final flag in similarFlags)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Flag(
              flag,
              size: 24,
            ),
          ),
      ],
    );
  }
}
