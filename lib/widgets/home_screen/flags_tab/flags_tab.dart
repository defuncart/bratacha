import 'package:bratacha/extensions/country_extensions.dart';
import 'package:bratacha/extensions/iterable_widget_extension.dart';
import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/modules/country_database/country_database.dart';
import 'package:bratacha/widgets/common/flag.dart';
import 'package:bratacha/widgets/common/panels/language_panel/language_cubit.dart';
import 'package:bratacha/widgets/home_screen/flags_tab/search_flags_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlagsTab extends StatelessWidget {
  const FlagsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.flagsTabLabelText),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => SearchFlagsCubit(
            context.read<LanguageCubit>().state,
          ),
          child: BlocBuilder<SearchFlagsCubit, List<Country>>(
            builder: (context, state) => ListView.separated(
              separatorBuilder: (_, __) => Divider(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              itemCount: state.length,
              itemBuilder: (_, index) => Padding(
                padding: EdgeInsets.only(
                  top: index == 0 ? 8 : 0,
                  bottom: index == state.length - 1 ? 8 : 0,
                ),
                child: ListTile(
                  leading: Flag(
                    state[index].id,
                    size: 48,
                  ),
                  title: Text(state[index].localizedName),
                  trailing: _SimilarFlagsList(
                    similarFlags: state[index].similarFlags,
                  ),
                ),
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
