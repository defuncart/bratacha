import 'package:bratacha/extensions/country_extensions.dart';
import 'package:bratacha/modules/country_database/country_database.dart';
import 'package:bratacha/widgets/common/flag.dart';
import 'package:flutter/material.dart';

class LearnScreen extends StatelessWidget {
  static const routeName = 'LearnScreen';

  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final countries = CountryService.countries;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView.separated(
          separatorBuilder: (_, __) => const Divider(),
          itemCount: countries.length,
          itemBuilder: (_, index) => Padding(
            padding:   EdgeInsets.only(top: index == 0 ? 8 : 0, bottom: index == countries.length - 1 ? 8: 0,) ,
            child: ListTile(
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
      ),
    );
  }
}

class _SimilarFlagsList extends StatelessWidget {
  const _SimilarFlagsList({
    required this.similarFlags,
  });

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
