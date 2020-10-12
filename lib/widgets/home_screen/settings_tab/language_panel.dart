import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguagePanel extends StatelessWidget {
  const LanguagePanel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(AppLocalizations.settingsTabLanguageLabel),
        BlocBuilder<LanguageCubit, String>(
          builder: (_, language) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final locale in AppLocalizationsDelegate.supportedLocals)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: _LanguageButton(
                    label: locale.languageCode,
                    isSelected: locale.languageCode == language,
                    onPressed: () => context.bloc<LanguageCubit>().setLanguage(locale.languageCode),
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }
}

class _LanguageButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final void Function() onPressed;

  const _LanguageButton({
    Key key,
    @required this.label,
    @required this.isSelected,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: isSelected ? Theme.of(context).accentColor : Theme.of(context).accentColor.withAlpha(128),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            label.toUpperCase(),
            style: TextStyle(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
