import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../route/route_list.dart';
import 'dashboard/cubit/dashboard_cubit.dart';
import 'dashboard/dashboard_screen.dart';
import 'home_page/bloc/home_page_bloc.dart';
import 'home_page/home_page_screen.dart';

class MainRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        RouteList.dashboard: (context) => BlocProvider(
              create: (context) => DashboardCubit(),
              child: DashboardScreen(),
            ),
        RouteList.homePage: (context) => BlocProvider(
              create: (context) => HomePageBloc(),
              child: HomePageScreen(),
            ),
      };
}
