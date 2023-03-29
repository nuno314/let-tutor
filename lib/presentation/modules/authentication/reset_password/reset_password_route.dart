import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/presentation/route/route_list.dart';

import 'bloc/reset_password_bloc.dart';
import 'views/reset_password_screen.dart';

class ResetPasswordRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        RouteList.resetPassword: (context) {
          final args = settings.arguments as ResetPasswordScreenArgs;
          return BlocProvider(
            create: (context) => ResetPasswordBloc(),
            child: ResetPasswordScreen(
              args: args,
            ),
          );
        },
      };
}
