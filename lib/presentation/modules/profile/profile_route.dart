import 'package:flutter/material.dart';
import 'package:let_tutor/presentation/route/route_list.dart';

import 'views/profile_screen.dart';

class ProfileRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        RouteList.profile: (context) {
          return ProfileScreen();
        },
      };
}
