import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as tag_format;

import '../client_info.dart';
import 'extensions.dart';

class AppEnglishDateLocale extends EnglishDateLocale {}

class AppVietnameseDateLocale extends VietnameseDateLocale {}

class DateUtils {
  static const List<String> normalFullFormat = [
    HH,
    ':',
    nn,
    ' - ',
    dd,
    '/',
    mm,
    '/',
    yyyy
  ];

  static const List<String> transactionFormat = [
    HH,
    ':',
    nn,
    ' - ',
    dd,
    ' thg ',
    mm,
    ', ',
    yyyy
  ];

  static const List<String> timeFormat = [
    HH,
    ':',
    nn,
  ];

  static const List<String> dateWithWeekdayFormat = [
    D,
    ', ',
    dd,
    '/',
    mm,
    '/',
    yyyy
  ];

  static const List<String> normalDateFormat = [dd, '/', mm, '/', yyyy];

  static const List<String> dateOfWeekFormat = [
    D,
    ', ',
    dd,
    ' thg ',
    mm,
    ', ',
    yyyy
  ];

  static const List<String> normalUTCFormat = [yyyy, '/', mm, '/', dd];

  static const List<String> bookingDateFormat = [dd, '/', mm, '/', yyyy];

  static const List<String> dateServerFormat = [yyyy, '-', mm, '-', dd];

  static const List<String> bookingDateTimeFormat = [
    HH,
    ':',
    nn,
    ', ',
    dd,
    '/',
    mm,
    '/',
    yyyy,
  ];

  static const List<String> dateCalendarFormat = [D, '\n', dd];
  static const List<String> monthAndYear = [mm, ' ', yyyy];
  static const List<String> yyyymmddHHnnss = [
    yyyy,
    '-',
    mm,
    '-',
    dd,
    ' ',
    HH,
    ':',
    nn,
    ':',
    ss
  ];
}

extension DateUtilsExtention on DateTime {
  String customFormat(List<String> format) {
    return formatDate(
      toLocal(),
      format,
    );
  }

  String serverToTransaction() {
    return formatDate(
      toLocal(),
      DateUtils.transactionFormat,
    );
  }

  String toMonthAndYearFormat() {
    return formatDate(
      toLocal(),
      DateUtils.monthAndYear,
    );
  }

  String serverToNormalDateFormat() {
    return formatDate(
      toLocal(),
      DateUtils.normalDateFormat,
    );
  }

  String toNormalDateFormat() {
    return formatDate(
      this,
      DateUtils.normalDateFormat,
    );
  }

  String serverToNormalFullFormat() {
    return formatDate(
      toLocal(),
      DateUtils.normalFullFormat,
    );
  }

  String serverToNormalUTCFullFormat() {
    return formatDate(
      toUtc(),
      DateUtils.normalFullFormat,
    );
  }

  String serverToDateOfWeek() {
    return formatDate(
      toLocal(),
      DateUtils.dateOfWeekFormat,
    );
  }

  String toServerNormalUTCFormat() {
    return formatDate(
      toUtc(),
      DateUtils.normalUTCFormat,
    );
  }

  String toDateServerFormat() {
    return formatDate(
      toUtc(),
      DateUtils.dateServerFormat,
    );
  }

  String toDateServerNormalFormat() {
    return formatDate(
      this,
      DateUtils.dateServerFormat,
    );
  }

  String toBookingDateTimeFormat() {
    return formatDate(
      toLocal(),
      DateUtils.bookingDateTimeFormat,
    );
  }

  String toUTCyyyymmddHHnnss() {
    return formatDate(
      toUtc(),
      DateUtils.yyyymmddHHnnss,
    );
  }

  String? timeago() {
    return tag_format.format(
      this,
      locale: ClientInfo.languageCode,
      allowFromNow: true,
    );
  }

  String toTimeFormat() {
    return formatDate(
      toLocal(),
      DateUtils.timeFormat,
    );
  }

  String toDateWithWeekdayFormat(BuildContext context) {
    return formatDate(
      toLocal(),
      DateUtils.dateWithWeekdayFormat,
      locale: Localizations.localeOf(context).languageCode == 'en'
          ? const EnglishDateLocale()
          : const VietnameseDateLocale(),
    );
  }

  String toOnlyMonthFullFormat(BuildContext context) {
    return formatDate(
      toLocal(),
      [M],
      locale: Localizations.localeOf(context).languageCode == 'en'
          ? const EnglishDateLocale()
          : const VietnameseDateLocale(),
    );
  }

  String toOnlYearFullFormat(BuildContext context) {
    return formatDate(
      toLocal(),
      [yyyy],
      locale: context.appDateLocale,
    );
  }

  String toDateCalendarFormat(BuildContext context) {
    return formatDate(
      toLocal(),
      DateUtils.dateCalendarFormat,
      locale: context.appDateLocale,
    );
  }
}
