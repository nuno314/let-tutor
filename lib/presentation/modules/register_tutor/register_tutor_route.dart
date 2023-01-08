import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/presentation/route/route_list.dart';

import 'bloc/register_tutor_bloc.dart';
import 'views/register_intro_video_screen.dart';
import 'views/register_tutor_screen.dart';

class RegisterTutorRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        RouteList.registerTutor: (context) {
          return BlocProvider(
            create: (context) => RegisterTutorBloc(),
            child: const RegisterTutorScreen(),
          );
        },
        RouteList.registerTutorIntroVideo: (context) {
          return RegisterTutorIntroVideoScreen();
        },
      };
}
