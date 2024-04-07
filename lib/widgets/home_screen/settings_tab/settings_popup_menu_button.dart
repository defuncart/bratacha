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
  const SettingsPopupMenuButton({
    required this.parentContext,
    super.key,
  });

  final BuildContext parentContext;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_Option>(
      icon: const Icon(Icons.info),
      onSelected: (option) {
        switch (option) {
          case _Option.dataPrivacy:
            _onDataPrivacySelected(parentContext);
            break;
          case _Option.credits:
            _onCreditsSelected(parentContext);
            break;
        }
      },
      color: Theme.of(context).scaffoldBackgroundColor,
      itemBuilder: (_) => [
        for (final option in _Option.values)
          PopupMenuItem<_Option>(
            value: option,
            child: Text(option.localizedText),
          )
      ],
    );
  }

  Future<void> _onDataPrivacySelected(BuildContext context) async {
    final appInfoService = context.read<IAppInfoService>();
    final response = await context.read<IDialogService>().requestCustomDialog(
          CustomDialogRequest(
            title: AppLocalizations.dataPrivacyDialogTitle,
            content: const DataPrivacyPanel(),
            buttonTexts: [
              AppLocalizations.dataPrivacyDialogViewLicensesLabel,
              AppLocalizations.generalClose,
            ],
          ),
        );

    if (response.buttonIndexPressed == 0) {
      // ignore: use_build_context_synchronously
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
      await context.read<IDialogService>().requestCustomDialog(
            CustomDialogRequest(
              title: AppLocalizations.creditsDialogTitle,
              content: const CreditsPanel(),
              buttonTexts: [
                AppLocalizations.generalClose,
              ],
            ),
          );
}

extension on _Option {
  String get localizedText {
    switch (this) {
      case _Option.dataPrivacy:
        return AppLocalizations.settingsTabDataPrivacyLabel;
      case _Option.credits:
        return AppLocalizations.settingsTabCreditsLabel;
    }
  }
}
