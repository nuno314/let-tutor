import 'package:flutter/material.dart';

import 'const/en.dart';
import 'const/vi.dart';

class AppLocale {
  static const vi = Locale('vi');
  static const en = Locale('en');
  static const defaultLocale = vi;

  static const supportedLocales = [vi, en];

  static bool isSupported(Locale locale) {
    return supportedLocales.any((e) => e.languageCode == locale.languageCode);
  }
}

abstract class AppConstantLocalization {
  static AppConstantLocalization of(BuildContext context) {
    if (Localizations.localeOf(context).languageCode ==
        AppLocale.en.languageCode) {
      return ENAppConstantLocalization();
    }
    return VIAppConstantLocalization();
  }

  String get cancel;
  String get takePhoto;
  String get selectPhoto;
  String get avatar;
  String get loading;
  String get confirm;
  String get choosePhoto;
  String get chooseVideo;
  String get camera;
  String get gallery;
  String get choosePhotoOrVideo;
  String get close;
  String get search;
  String get error;
  String get ok;
  String get warning;
  String get orderByDesc;
  String get orderByAsc;
  String get openSetting;
  String get haveNoPermission;
}
