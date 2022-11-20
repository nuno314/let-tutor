part of '../utils.dart';

extension ExtendedIterable<E> on Iterable<E> {
  /// Like Iterable<T>.map but callback have index as second argument
  Iterable<T> mapIndex<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }

  void forEachIndex(void Function(E e, int i) f) {
    var i = 0;
    forEach((e) => f(e, i++));
  }
}

extension NullableStringIsNullOrEmptyExtension on String? {
  /// Returns `true` if the String is either null or empty.
  bool get isNullOrEmpty => this?.isEmpty ?? true;
}

extension NullableStringIsNotNullOrEmptyExtension on String? {
  bool get isNotNullOrEmpty => !isNullOrEmpty;
}

extension StringExt on String {
  String displayNationalNumber() {
    return PhoneNumberUtils.parse(this)?.nationalNumber ?? '';
  }

  bool validVNPhoneNumber() {
    return PhoneNumberUtils.parse(this) != null;
  }

  bool isValidPhoneNumber() {
    if (isNullOrEmpty) {
      return false;
    }

    const pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(this)) {
      return false;
    }
    return true;
  }

  bool isEmail() {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(this);
  }

  bool get isValidPassword {
    final length = this.length;
    final hasLetter = contains(RegExp(r'[a-zA-Z]'));
    final hasNumber = contains(RegExp(r'[0-9]'));
    final isValid = (length >= 8) && hasLetter && hasNumber;
    return isValid;
  }

  bool get isLocalUrl {
    return startsWith('/') ||
        startsWith('file://') ||
        (length > 1 && substring(1).startsWith(':\\'));
  }

  bool get isUrl => Uri.parse(this).isAbsolute;

  String capitalizeFisrt() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  String capitalizeFirstofEach() {
    return split(' ').map((str) => str.capitalizeFisrt()).join(' ');
  }

  Duration parseDuration() {
    var hours = 0;
    var minutes = 0;
    var micros = 0;
    final parts = split(':');
    try {
      if (parts.isNotEmpty) {
        hours = int.parse(parts.first);
      }
      if (parts.length > 1) {
        minutes = int.parse(parts[1]);
      }
      if (parts.length > 2) {
        micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
      }
      return Duration(hours: hours, minutes: minutes, microseconds: micros);
    } catch (_) {
      return Duration.zero;
    }
  }
}

extension CoreListExtension<E> on List<E>? {
  E? get firstOrNull {
    if (this?.isNotEmpty == true) {
      return this!.first;
    }
    return null;
  }
}

extension DoubleExt on double {
  String toStringAsMaxFixed(int fractionDigits) {
    final formatter = NumberFormat()
      ..minimumFractionDigits = 0
      ..maximumFractionDigits = fractionDigits;
    return formatter.format(this);
  }
}

extension DistanceExt on double? {
  String get metterToKMDisplay {
    if (this == null) {
      return '--';
    }
    return (this! / 1000).toStringAsFixed(1);
  }
}

extension DateTimeConverter on int? {
  String toFullDateTime() {
    if (this == null) {
      return '';
    }
    final dt = DateTime.fromMillisecondsSinceEpoch(this!);
    return dt.serverToNormalFullFormat();
  }
}

extension CurrencyExt on num? {
  String toAppCurrencyString({bool isWithSymbol = true, String? locale}) {
    return NumberFormat.currency(
      locale: locale ?? AppLocale.defaultLocale.languageCode,
      symbol: isWithSymbol ? 'đ' : '',
      customPattern: '#,###${isWithSymbol ? '\u00a4' : ''}',
    ).format(this ?? 0);
  }

  String displayMoney() {
    return NumberFormatUtils.displayMoney(this) ?? '--';
  }
}

extension DateConverter on String? {
  String toDisplayNormalDate() {
    if (this == null || this?.isEmpty == true) {
      return '';
    }
    final dt = DateTime.parse(this!);
    return dt.serverToNormalDateFormat();
  }
}

extension PhoneNumberExt on String? {
  String displayPhoneNumber() {
    if (isNullOrEmpty) {
      return '';
    }
    return PhoneNumberUtils.parse(this!)?.national ?? '';
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isBeforeDate(DateTime other) {
    return !isSameDay(other) && isBefore(other);
  }

  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    bool? isUtc,
  }) {
    return ((isUtc ?? this.isUtc) ? DateTime.utc : DateTime.new)(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
    );
  }

  DateTime get startDate {
    return DateTime(year, month, day);
  }

  DateTime get endDate {
    return DateTime(year, month, day, 23, 59, 59);
  }
}

extension ObjectExt<T> on T {
  R let<R>(R Function(T that) op) => op(this);
}

extension WeightExt on int {
  String formatNumber({String prefix = ''}) {
    const pattern = r'(\d{1,3})(?=(\d{3})+(?!\d))';
    final regExp = RegExp(pattern);
    final mathFunc = (Match match) => '${match[1]},';
    return '${toString().replaceAllMapped(regExp, mathFunc)}$prefix';
  }
}

