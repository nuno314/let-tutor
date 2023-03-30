import 'package:flutter/material.dart';

import '../../route/route_list.dart';
import 'views/schedule_screen.dart';

class ScheduleRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        RouteList.schedule: (context) {
          return ScheduleScreen();
        },
      };
}
