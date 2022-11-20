import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../route/route_list.dart';
import 'bloc/schedule_bloc.dart';
import 'views/schedule_screen.dart';

class ScheduleRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        RouteList.schedule: (context) {
          return BlocProvider(
            create: (context) => ScheduleBloc(),
            child: const ScheduleScreen(),
          );
        },
      };
}
