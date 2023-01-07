import 'package:flutter/cupertino.dart';
import 'package:let_tutor/presentation/modules/authentication/authentication_route.dart';
import 'package:let_tutor/presentation/modules/authentication/reset_password/reset_password.dart';
import 'package:let_tutor/presentation/modules/meeting/meeting.dart';
import 'package:let_tutor/presentation/modules/profile/profile.dart';
import 'package:let_tutor/presentation/modules/settings/settings_route.dart';
import 'package:let_tutor/presentation/modules/tutor/tutor.dart';
import 'package:let_tutor/presentation/modules/wallet/wallet.dart';

import '../common_widget/text_scale_fixed.dart';
import '../modules/main/main_route.dart';
import '../modules/welcome/welcome_route.dart';

class RouteGenerator {
  static Map<String, WidgetBuilder> _getAll(RouteSettings settings) => {
        ...WelcomeRoute.getAll(settings),
        ...MainRoute.getAll(settings),
        ...ResetPasswordRoute.getAll(settings),
        ...ProfileRoute.getAll(settings),
        ...AuthenticationRoute.getAll(settings),
        ...SettingsRoute.getAll(settings),
        ...WalletRoute.getAll(settings),
        ...TutorRoute.getAll(settings),
        ...MeetingRoute.getAll(settings),
      };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final _builder = _getAll(settings)[settings.name!];

    return buildRoute(
      _builder ?? (context) => const SizedBox(),
      settings: settings,
    );
  }
}

Route buildRoute<T>(WidgetBuilder builder, {RouteSettings? settings}) {
  return CupertinoPageRoute<T>(
    builder: (context) => TextScaleFixed(
      child: builder(context),
    ),
    settings: settings,
  );
}
