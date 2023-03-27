import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/data/data_source/remote/app_api_service.dart';
import 'package:let_tutor/di/di.dart';
import 'package:let_tutor/presentation/route/route_list.dart';

import 'bloc/profile_bloc.dart';
import 'views/profile_screen.dart';

class ProfileRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        RouteList.profile: (context) {
          return BlocProvider(
            create: (context) =>
                ProfileBloc(restApi: injector.get<AppApiService>().client),
            child: const ProfileScreen(),
          );
        },
      };
}
