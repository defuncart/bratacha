import 'package:bratacha/intl/localizations.dart';
import 'package:bratacha/modules/dialog_manager/dialog_manager.dart';
import 'package:bratacha/services/app_info_service/i_app_info_service.dart';
import 'package:bratacha/widgets/common/panels/data_privacy_panel.dart';
import 'package:bratacha/widgets/home_screen/settings_tab/credits_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum _Option {
  dataPrivacy,
  credits,
}

class SettingsPopupMenuButton extends StatelessWidget {
  final BuildContext parentContext;

  const SettingsPopupMenuButton({
    Key key,
    @required this.parentContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapOptionText = {
      _Option.dataPrivacy: AppLocalizations.settingsTabDataPrivacyLabel,
      _Option.credits: AppLocalizations.settingsTabCreditsLabel,
    };

    // final mapOptionCallback = {
    //   _Option.dataPrivacy: (BuildContext context) async => _onDataPrivacySelected(parentContext),
    //   _Option.credits: (BuildContext context) async => _onCreditsSelected(parentContext),
    // };

    return PopupMenuButton<_Option>(
      icon: Icon(Icons.info),
      // onSelected: (option) => mapOptionCallback[option](context),
      onSelected: (option) => _onSelected(option, context),
      color: Theme.of(context).scaffoldBackgroundColor,
      itemBuilder: (_) => [
        for (final option in _Option.values)
          PopupMenuItem<_Option>(
            value: option,
            child: Text(mapOptionText[option]),
          )
      ],
    );
  }

  void _onSelected(_Option option, BuildContext context) {
    switch (option) {
      case _Option.dataPrivacy:
        _onDataPrivacySelected(context);
        break;
      case _Option.credits:
        _onCreditsSelected(context);
    }
  }

  Future<void> _onDataPrivacySelected(BuildContext context) async {
    final response = await context.repository<IDialogService>().requestCustomDialog(
          CustomDialogRequest(
            title: AppLocalizations.dataPrivacyDialogTitle,
            content: DataPrivacyPanel(),
            buttonTexts: [
              AppLocalizations.dataPrivacyDialogViewLicensesLabel,
              AppLocalizations.generalClose,
            ],
          ),
        );

    if (response.buttonIndexPressed == 0) {
      final appInfoService = context.repository<IAppInfoService>();
      showLicensePage(
        context: context,
        applicationName: appInfoService.applicationName,
        applicationVersion: appInfoService.applicationVersion,
        applicationIcon: appInfoService.applicationIcon,
        applicationLegalese: appInfoService.applicationLegalese,
      );
    }
  }

  Future<void> _onCreditsSelected(BuildContext context) async =>
      await context.repository<IDialogService>().requestCustomDialog(
            CustomDialogRequest(
              title: AppLocalizations.creditsDialogTitle,
              content: CreditsPanel(),
              buttonTexts: [
                AppLocalizations.generalClose,
              ],
            ),
          );
}
