import 'package:flutter/material.dart';

import 'views/histories_screen.dart';

class HistoriesRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        '': (context) {
          return HistoriesScreen();
        },
      };
}
