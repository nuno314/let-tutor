import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../route/route_list.dart';
import 'bloc/home_page_bloc.dart';
import 'home_page_screen.dart';

class HomePageRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        RouteList.dashboard: (context) => BlocProvider(
              create: (context) => HomePageBloc(),
              child: HomePageScreen(),
            ),
      };
}
