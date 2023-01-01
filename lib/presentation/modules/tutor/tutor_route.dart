import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/domain/entities/tutor_list_filter.entity.dart';
import 'package:let_tutor/presentation/modules/tutor/views/tutor_filter_screen.dart';

import '../../route/route_list.dart';
import 'bloc/tutor_bloc.dart';
import 'views/tutor_screen.dart';

class TutorRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        //TODO: Update route name
        '': (context) {
          return BlocProvider(
            create: (context) => TutorBloc(),
            child: const TutorScreen(),
          );
        },
        RouteList.tutorFilter: (context) {
          return TutorFilterScreen(
            filter: settings.arguments as TutorListFilter,
          );
        }
      };
}
