import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/histories_bloc.dart';
import 'views/histories_screen.dart';

class HistoriesRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        '': (context) {
          return BlocProvider(
            create: (context) => HistoriesBloc(),
            child: const HistoriesScreen(),
          );
        },
      };
}
