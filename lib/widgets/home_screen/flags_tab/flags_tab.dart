import 'package:bratacha/extensions/country_extensions.dart';
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
    return BlocProvider(
      create: (context) => SearchFlagsCubit(
        context.read<LanguageCubit>().state,
      ),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: _FlagsAppBar(
            onSearchTermChanged: context.read<SearchFlagsCubit>().update,
          ),
          body: SafeArea(
            child: BlocBuilder<SearchFlagsCubit, List<Country>>(
              builder: (context, state) => ListView.separated(
                separatorBuilder: (_, _) => Divider(
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
                    // trailing: _SimilarFlagsList(
                    //   similarFlags: state[index].similarFlags,
                    // ),
                    // trailing: IconButton(
                    //   icon: Icon(MdiIcons.wikipedia),
                    //   onPressed: () {},
                    // ),
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

class _FlagsAppBar extends StatefulWidget implements PreferredSizeWidget {
  final void Function(String) onSearchTermChanged;

  const _FlagsAppBar({
    required this.onSearchTermChanged,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<_FlagsAppBar> createState() => _FlagsAppBarState();
}

class _FlagsAppBarState extends State<_FlagsAppBar> {
  var _isTextFieldActive = false;
  var _showClearButton = false;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController()
      ..addListener(() {
        final showClearButton = _controller.text.isNotEmpty;
        if (_showClearButton != showClearButton) {
          setState(() => _showClearButton = showClearButton);
        }
        widget.onSearchTermChanged(_controller.text);
      });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: _isTextFieldActive
          ? BackButton(
              onPressed: () {
                setState(() => _isTextFieldActive = false);
                _controller.clear();
              },
            )
          : null,
      title: _isTextFieldActive
          ? TextField(
              controller: _controller,
              autofocus: true,
              decoration: InputDecoration(
                hintText: context.l10n.flagsTabSearchTermHint,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
              cursorColor: Theme.of(context).textTheme.bodyLarge?.color,
            )
          : Text(context.l10n.flagsTabLabelText),
      actions: [
        if (!_isTextFieldActive)
          IconButton(
            onPressed: () => setState(() => _isTextFieldActive = true),
            icon: const Icon(Icons.search),
          )
        else if (_showClearButton)
          IconButton(
            onPressed: _controller.clear,
            icon: const Icon(Icons.clear),
          )
        else
          const SizedBox(
            height: 40,
            width: 40,
          ),
      ],
    );
  }
}

/// TODO(Add back, remove entirely or replace with wiki link)
// ignore: unused_element
class _SimilarFlagsList extends StatelessWidget {
  const _SimilarFlagsList({
    required this.similarFlags,
  });

  final List<String> similarFlags;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: [
        for (final flag in similarFlags)
          Flag(
            flag,
            size: 24,
          ),
      ],
    );
  }
}
