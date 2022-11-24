import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/presentation/modules/settings/change_password/bloc/change_password_bloc.dart';
import 'package:let_tutor/presentation/modules/settings/change_password/change_password_screen.dart';
import 'package:let_tutor/presentation/route/route_list.dart';

import 'bloc/settings_bloc.dart';
import 'views/settings_screen.dart';

class SettingsRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        RouteList.settings: (context) {
          return BlocProvider(
            create: (context) => SettingsBloc(),
            child: const SettingsScreen(),
          );
        },
        RouteList.changePassword: (context) => BlocProvider(
              create: (context) => ChangePasswordBloc(),
              child: const ChangePasswordScreen(),
            ),
      };
}
