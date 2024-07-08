import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart' as intl;
import 'package:intl/intl.dart' as intl;

// Taken from https://github.com/flutter/website/blob/archived-master/examples/internationalization/add_language/lib/nn_intl.dart
class _GaMaterialLocalizationsDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  const _GaMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'ga';

  @override
  Future<MaterialLocalizations> load(Locale locale) async {
    const localeName = 'en';
    await intl.initializeDateFormatting(localeName, null);
    return SynchronousFuture<MaterialLocalizations>(
      GaMaterialLocalizations(
        localeName: localeName,
        fullYearFormat: intl.DateFormat('y', localeName),
        compactDateFormat: intl.DateFormat('yMd', localeName),
        shortDateFormat: intl.DateFormat('yMMMd', localeName),
        mediumDateFormat: intl.DateFormat('EEE, MMM d', localeName),
        longDateFormat: intl.DateFormat('EEEE, MMMM d, y', localeName),
        yearMonthFormat: intl.DateFormat('MMMM y', localeName),
        shortMonthDayFormat: intl.DateFormat('MMM d'),
        decimalFormat: intl.NumberFormat('#,##0.###', localeName),
        twoDigitZeroPaddedFormat: intl.NumberFormat('00', localeName),
      ),
    );
  }

  @override
  bool shouldReload(_GaMaterialLocalizationsDelegate old) => false;
}

class GaMaterialLocalizations extends GlobalMaterialLocalizations {
  const GaMaterialLocalizations({
    super.localeName = 'ga',
    required super.fullYearFormat,
    required super.compactDateFormat,
    required super.shortDateFormat,
    required super.mediumDateFormat,
    required super.longDateFormat,
    required super.yearMonthFormat,
    required super.shortMonthDayFormat,
    required super.decimalFormat,
    required super.twoDigitZeroPaddedFormat,
  });

  static const LocalizationsDelegate<MaterialLocalizations> delegate = _GaMaterialLocalizationsDelegate();

  @override
  String get moreButtonTooltip => throw UnimplementedError();

  @override
  String get aboutListTileTitleRaw => throw UnimplementedError();

  @override
  // TODO: Translate
  String get alertDialogLabel => 'alertDialogLabel';

  @override
  String get anteMeridiemAbbreviation => throw UnimplementedError();

  @override
  // TODO: Translate
  String get backButtonTooltip => 'backButtonTooltip';

  @override
  String get cancelButtonLabel => throw UnimplementedError();

  @override
  // TODO: Translate
  String get closeButtonLabel => 'closeButtonLabel';

  @override
  String get closeButtonTooltip => throw UnimplementedError();

  @override
  String get collapsedIconTapHint => throw UnimplementedError();

  @override
  // TODO: Translate
  String get continueButtonLabel => 'continueButtonLabel';

  @override
  String get copyButtonLabel => throw UnimplementedError();

  @override
  String get cutButtonLabel => throw UnimplementedError();

  @override
  String get deleteButtonTooltip => throw UnimplementedError();

  @override
  String get dialogLabel => throw UnimplementedError();

  @override
  String get drawerLabel => throw UnimplementedError();

  @override
  String get expandedIconTapHint => throw UnimplementedError();

  @override
  String get firstPageTooltip => throw UnimplementedError();

  @override
  String get hideAccountsLabel => throw UnimplementedError();

  @override
  String get lastPageTooltip => throw UnimplementedError();

  @override
  String get licensesPageTitle => 'licensesPageTitle';

  @override
  String get modalBarrierDismissLabel => 'modalBarrierDismissLabel';

  @override
  String get nextMonthTooltip => throw UnimplementedError();

  @override
  String get nextPageTooltip => throw UnimplementedError();

  @override
  String get okButtonLabel => throw UnimplementedError();

  @override
  String get openAppDrawerTooltip => throw UnimplementedError();

  @override
  String get pageRowsInfoTitleRaw => throw UnimplementedError();

  @override
  String get pageRowsInfoTitleApproximateRaw => throw UnimplementedError();

  @override
  String get pasteButtonLabel => throw UnimplementedError();

  @override
  String get popupMenuLabel => 'popupMenuLabel';

  @override
  String get postMeridiemAbbreviation => throw UnimplementedError();

  @override
  String get previousMonthTooltip => throw UnimplementedError();

  @override
  String get previousPageTooltip => throw UnimplementedError();

  @override
  String get refreshIndicatorSemanticLabel => throw UnimplementedError();

  @override
  String? get remainingTextFieldCharacterCountFew => throw UnimplementedError();

  @override
  String? get remainingTextFieldCharacterCountMany => throw UnimplementedError();

  @override
  String get remainingTextFieldCharacterCountOne => throw UnimplementedError();

  @override
  String get remainingTextFieldCharacterCountOther => throw UnimplementedError();

  @override
  String? get remainingTextFieldCharacterCountTwo => throw UnimplementedError();

  @override
  String get remainingTextFieldCharacterCountZero => throw UnimplementedError();

  @override
  String get reorderItemDown => throw UnimplementedError();

  @override
  String get reorderItemLeft => throw UnimplementedError();

  @override
  String get reorderItemRight => throw UnimplementedError();

  @override
  String get reorderItemToEnd => throw UnimplementedError();

  @override
  String get reorderItemToStart => throw UnimplementedError();

  @override
  String get reorderItemUp => throw UnimplementedError();

  @override
  String get rowsPerPageTitle => throw UnimplementedError();

  @override
  ScriptCategory get scriptCategory => ScriptCategory.englishLike;

  @override
  String get searchFieldLabel => throw UnimplementedError();

  @override
  String get selectAllButtonLabel => throw UnimplementedError();

  @override
  String? get selectedRowCountTitleFew => throw UnimplementedError();

  @override
  String? get selectedRowCountTitleMany => throw UnimplementedError();

  @override
  String get selectedRowCountTitleOne => throw UnimplementedError();

  @override
  String get selectedRowCountTitleOther => throw UnimplementedError();

  @override
  String? get selectedRowCountTitleTwo => throw UnimplementedError();

  @override
  String get selectedRowCountTitleZero => throw UnimplementedError();

  @override
  String get showAccountsLabel => throw UnimplementedError();

  @override
  // TODO: Translate
  String get showMenuTooltip => 'showMenuTooltip';

  @override
  String get signedInLabel => throw UnimplementedError();

  @override
  // TODO: Translate
  String get tabLabelRaw => r'Tab $tabIndex of $tabCount';

  @override
  TimeOfDayFormat get timeOfDayFormatRaw => throw UnimplementedError();

  @override
  String get timePickerHourModeAnnouncement => throw UnimplementedError();

  @override
  String get timePickerMinuteModeAnnouncement => throw UnimplementedError();

  @override
  // TODO: Translate
  String get viewLicensesButtonLabel => 'viewLicensesButtonLabel';

  @override
  List<String> get narrowWeekdays => throw UnimplementedError();

  @override
  // TODO: Translate
  int get firstDayOfWeekIndex => 0;

  @override
  String get calendarModeButtonLabel => throw UnimplementedError();

  @override
  String get dateHelpText => throw UnimplementedError();

  @override
  String get dateInputLabel => throw UnimplementedError();

  @override
  String get dateOutOfRangeLabel => throw UnimplementedError();

  @override
  String get datePickerHelpText => throw UnimplementedError();

  @override
  String get dateRangeEndDateSemanticLabelRaw => throw UnimplementedError();

  @override
  String get dateRangeEndLabel => throw UnimplementedError();

  @override
  String get dateRangePickerHelpText => throw UnimplementedError();

  @override
  String get dateRangeStartDateSemanticLabelRaw => throw UnimplementedError();

  @override
  String get dateRangeStartLabel => throw UnimplementedError();

  @override
  String get dateSeparator => throw UnimplementedError();

  @override
  String get dialModeButtonLabel => throw UnimplementedError();

  @override
  String get inputDateModeButtonLabel => throw UnimplementedError();

  @override
  String get inputTimeModeButtonLabel => throw UnimplementedError();

  @override
  String get invalidDateFormatLabel => throw UnimplementedError();

  @override
  String get invalidDateRangeLabel => throw UnimplementedError();

  @override
  String get invalidTimeLabel => throw UnimplementedError();

  @override
  String get licensesPackageDetailTextOther => 'licensesPackageDetailTextOther';

  @override
  String get saveButtonLabel => throw UnimplementedError();

  @override
  String get selectYearSemanticsLabel => throw UnimplementedError();

  @override
  String get timePickerDialHelpText => throw UnimplementedError();

  @override
  String get timePickerHourLabel => throw UnimplementedError();

  @override
  String get timePickerInputHelpText => throw UnimplementedError();

  @override
  String get timePickerMinuteLabel => throw UnimplementedError();

  @override
  String get unspecifiedDate => throw UnimplementedError();

  @override
  String get unspecifiedDateRange => throw UnimplementedError();

  @override
  String get bottomSheetLabel => throw UnimplementedError();

  @override
  String get collapsedHint => throw UnimplementedError();

  @override
  String get currentDateLabel => throw UnimplementedError();

  @override
  String get expandedHint => throw UnimplementedError();

  @override
  String get expansionTileCollapsedHint => throw UnimplementedError();

  @override
  String get expansionTileCollapsedTapHint => throw UnimplementedError();

  @override
  String get expansionTileExpandedHint => throw UnimplementedError();

  @override
  String get expansionTileExpandedTapHint => throw UnimplementedError();

  @override
  String get keyboardKeyAlt => throw UnimplementedError();

  @override
  String get keyboardKeyAltGraph => throw UnimplementedError();

  @override
  String get keyboardKeyBackspace => throw UnimplementedError();

  @override
  String get keyboardKeyCapsLock => throw UnimplementedError();

  @override
  String get keyboardKeyChannelDown => throw UnimplementedError();

  @override
  String get keyboardKeyChannelUp => throw UnimplementedError();

  @override
  String get keyboardKeyControl => throw UnimplementedError();

  @override
  String get keyboardKeyDelete => throw UnimplementedError();

  @override
  String get keyboardKeyEject => throw UnimplementedError();

  @override
  String get keyboardKeyEnd => throw UnimplementedError();

  @override
  String get keyboardKeyEscape => throw UnimplementedError();

  @override
  String get keyboardKeyFn => throw UnimplementedError();

  @override
  String get keyboardKeyHome => throw UnimplementedError();

  @override
  String get keyboardKeyInsert => throw UnimplementedError();

  @override
  String get keyboardKeyMeta => throw UnimplementedError();

  @override
  String get keyboardKeyMetaMacOs => throw UnimplementedError();

  @override
  String get keyboardKeyMetaWindows => throw UnimplementedError();

  @override
  String get keyboardKeyNumLock => throw UnimplementedError();

  @override
  String get keyboardKeyNumpad0 => throw UnimplementedError();

  @override
  String get keyboardKeyNumpad1 => throw UnimplementedError();

  @override
  String get keyboardKeyNumpad2 => throw UnimplementedError();

  @override
  String get keyboardKeyNumpad3 => throw UnimplementedError();

  @override
  String get keyboardKeyNumpad4 => throw UnimplementedError();

  @override
  String get keyboardKeyNumpad5 => throw UnimplementedError();

  @override
  String get keyboardKeyNumpad6 => throw UnimplementedError();

  @override
  String get keyboardKeyNumpad7 => throw UnimplementedError();

  @override
  String get keyboardKeyNumpad8 => throw UnimplementedError();

  @override
  String get keyboardKeyNumpad9 => throw UnimplementedError();

  @override
  String get keyboardKeyNumpadAdd => throw UnimplementedError();

  @override
  String get keyboardKeyNumpadComma => throw UnimplementedError();

  @override
  String get keyboardKeyNumpadDecimal => throw UnimplementedError();

  @override
  String get keyboardKeyNumpadDivide => throw UnimplementedError();

  @override
  String get keyboardKeyNumpadEnter => throw UnimplementedError();

  @override
  String get keyboardKeyNumpadEqual => throw UnimplementedError();

  @override
  String get keyboardKeyNumpadMultiply => throw UnimplementedError();

  @override
  String get keyboardKeyNumpadParenLeft => throw UnimplementedError();

  @override
  String get keyboardKeyNumpadParenRight => throw UnimplementedError();

  @override
  String get keyboardKeyNumpadSubtract => throw UnimplementedError();

  @override
  String get keyboardKeyPageDown => throw UnimplementedError();

  @override
  String get keyboardKeyPageUp => throw UnimplementedError();

  @override
  String get keyboardKeyPower => throw UnimplementedError();

  @override
  String get keyboardKeyPowerOff => throw UnimplementedError();

  @override
  String get keyboardKeyPrintScreen => throw UnimplementedError();

  @override
  String get keyboardKeyScrollLock => throw UnimplementedError();

  @override
  String get keyboardKeySelect => throw UnimplementedError();

  @override
  String get keyboardKeyShift => throw UnimplementedError();

  @override
  String get keyboardKeySpace => throw UnimplementedError();

  @override
  String get lookUpButtonLabel => throw UnimplementedError();

  @override
  String get menuBarMenuLabel => throw UnimplementedError();

  @override
  // TODO: Translate
  String get menuDismissLabel => 'menuDismissLabel';

  @override
  String get scanTextButtonLabel => throw UnimplementedError();

  @override
  String get scrimLabel => throw UnimplementedError();

  @override
  String get scrimOnTapHintRaw => throw UnimplementedError();

  @override
  String get searchWebButtonLabel => throw UnimplementedError();

  @override
  String get shareButtonLabel => throw UnimplementedError();

  @override
  String get clearButtonTooltip => throw UnimplementedError();

  @override
  String get selectedDateLabel => throw UnimplementedError();
}
