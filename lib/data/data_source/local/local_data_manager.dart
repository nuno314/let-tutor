import 'dart:async';

import '../../../common/utils.dart';
import '../../../di/di.dart';
import '../../../presentation/theme/theme_data.dart';
import '../../models/token.dart';
import '../../models/user.dart';
import 'preferences_helper/preferences_helper.dart';

class LocalDataManager extends AppPreferenceData {
  late final PreferencesHelper _preferencesHelper = injector.get();

  static Future<LocalDataManager> init() async {
    return Future.value(LocalDataManager());
  }

  final _userChangedController = StreamController<User?>.broadcast();
  User? _currentUser;

  Stream<User?> get onUserChanged {
    return _userChangedController.stream;
  }

  User? get currentUser {
    return _currentUser;
  }

  void notifyUserChanged(User? user) {
    LogUtils.d('_notifyUserChanged: ${user?.id}');
    _userChangedController.add(user);
    _currentUser = user;
  }

  ////////////////////////////////////////////////////////
  ///             Preferences helper
  ///
  ///
  /// /// Token
  @override
  String? get accessToken => _preferencesHelper.accessToken;

  @override
  String? get refreshToken => _preferencesHelper.refreshToken;

  @override
  Future<bool?> setAccessToken(AccessToken? value) {
    return _preferencesHelper.setAccessToken(value);
  }

  @override
  Future<bool?> setRefreshToken(RefreshToken? value) {
    return _preferencesHelper.setRefreshToken(value);
  }

  @override
  SupportedTheme getTheme() {
    return _preferencesHelper.getTheme();
  }

  @override
  Future<bool?> setTheme(String? data) {
    return _preferencesHelper.setTheme(data);
  }

  @override
  String? getLocalization() {
    return _preferencesHelper.getLocalization();
  }

  @override
  Future<bool?> saveLocalization(String? locale) {
    return _preferencesHelper.saveLocalization(locale);
  }

  @override
  Future<bool?> clearData() {
    return _preferencesHelper.clearData();
  }
}
