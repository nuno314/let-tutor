import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/presentation/route/route_list.dart';

import 'bloc/teacher_bloc.dart';
import 'views/teacher_screen.dart';

class TeacherRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        //TODO: Update route name
        RouteList.teacherList: (context) {
          return BlocProvider(
            create: (context) => TeacherBloc(),
            child: const TeacherScreen(),
          );
        },
      };
}
