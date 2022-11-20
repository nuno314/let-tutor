import 'package:flutter/cupertino.dart';
import 'package:let_tutor/presentation/modules/authentication/authentication_route.dart';
import 'package:let_tutor/presentation/modules/authentication/reset_password/reset_password.dart';
import 'package:let_tutor/presentation/modules/profile/profile.dart';

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
