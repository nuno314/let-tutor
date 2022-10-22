import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../route/route_list.dart';
import 'bloc/dashboard_bloc.dart';
import 'dashboard_screen.dart';

class DashboardRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        RouteList.dashBoardRoute: (context) => BlocProvider(
              create: (context) => DashboardBloc(),
              child: DashboardScreen(),
            ),
      };
}
