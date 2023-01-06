import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/courses_bloc.dart';
import 'views/courses_screen.dart';

class CoursesRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        //TODO: Update route name
        '': (context) {
          return BlocProvider(
            create: (context) => CoursesBloc(),
            child: const CoursesScreen(),
          );
        },
      };
}
