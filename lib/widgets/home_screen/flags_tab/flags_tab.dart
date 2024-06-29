import 'package:bratacha/extensions/country_extensions.dart';
import 'package:bratacha/extensions/iterable_widget_extension.dart';
import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/modules/country_database/country_database.dart';
import 'package:bratacha/widgets/common/flag.dart';
import 'package:flutter/material.dart';

class FlagsTab extends StatelessWidget {
  const FlagsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final countries = CountryService.countries;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.flagsTabLabelText),
      ),
      body: SafeArea(
        child: ListView.separated(
          separatorBuilder: (_, __) => Divider(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          itemCount: countries.length,
          itemBuilder: (_, index) => Padding(
            padding: EdgeInsets.only(
              top: index == 0 ? 8 : 0,
              bottom: index == countries.length - 1 ? 8 : 0,
            ),
            child: ListTile(
              leading: Flag(
                countries[index].id,
                size: 48,
              ),
              title: Text(countries[index].localizedName),
              trailing: _SimilarFlagsList(
                similarFlags: countries[index].similarFlags,
              ),
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final flag in similarFlags)
          Flag(
            flag,
            size: 24,
          ),
      ].intersperse(const SizedBox(width: 4)),
    );
  }
}
