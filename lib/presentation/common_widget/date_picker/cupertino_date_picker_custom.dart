import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/theme_color.dart';
import 'custom_picker_model.dart';
import 'flutter_datetime_picker/flutter_datetime_picker.dart';

Future<dynamic> showMyCustomDatePicker(
  BuildContext context,
  DateTime? initialDateTime,
  Function(DateTime?)? onConfirmed, {
  Function(DateTime?)? onChanged,
  DateTime? maxDate,
  DateTime? minDate,
}) {
  return DatePicker.showPicker(
    context,
    showTitleActions: true,
    onChanged: onChanged,
    onConfirm: onConfirmed,
    locale: LocaleType.vi,
    pickerModel: DateDDMMYYYModel(
      minTime: minDate,
      maxTime: maxDate,
      currentTime: initialDateTime,
      locale: LocaleType.values
              .where((element) =>
                  element.name == Localizations.localeOf(context).languageCode)
              .firstOrNull ??
          LocaleType.vi,
    ),
  );
}

Future<dynamic> showMyCustomMonthPicker(
  BuildContext context,
  DateTime? initialDateTime,
  AppColor? theme,
  Function(DateTime?)? onConfirmed, {
  Function(DateTime?)? onChanged,
  DateTime? maxDate,
  DateTime? minDate,
}) {
  return DatePicker.showPicker(
    context,
    showTitleActions: true,
    onChanged: onChanged,
    onConfirm: onConfirmed,
    locale: LocaleType.vi,
    pickerModel: DateMMYYYModel(
      minTime: minDate,
      maxTime: maxDate,
      currentTime: initialDateTime,
      locale: LocaleType.values
              .where((element) =>
                  element.name == Localizations.localeOf(context).languageCode)
              .firstOrNull ??
          LocaleType.vi,
    ),
  );
}
