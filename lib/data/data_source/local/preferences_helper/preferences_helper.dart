import 'package:injectable/injectable.dart';
import 'package:let_tutor/common/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../di/di.dart';
import '../../../../presentation/theme/theme_data.dart';
import '../../../models/token.dart';
import 'preferences_key.dart';

part 'impl/preferences_helper.impl.dart';

abstract class PreferencesHelper extends AppPreferenceData {}

abstract class AppPreferenceData {
  /// Token
  String? get accessToken;

  String? get refreshToken;

  Future<bool?> setAccessToken(AccessToken? value);

  Future<bool?> setRefreshToken(RefreshToken? value);

  SupportedTheme getTheme();

  Future<bool?> setTheme(String? data);

  String? getLocalization();

  Future<bool?> saveLocalization(String? locale);

  Future<bool?> clearData();
}
