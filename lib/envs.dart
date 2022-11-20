import 'package:flutter/foundation.dart';

class Env {
  static const environment = 'environment';
  static const developmentMode = 'developmentMode';
  static const appName = 'appname';
  static const baseApiLayer = 'baseApiLayer';

  static const devEnvName = 'Development';

  static final Map<String, dynamic> devEnv = {
    environment: devEnvName,
    developmentMode: kDebugMode,
    appName: 'FBS_Dev',
    baseApiLayer: 'https://sandbox.api.lettutor.com/',
  };
}
