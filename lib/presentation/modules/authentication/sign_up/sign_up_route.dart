import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../route/route_list.dart';
import 'bloc/sign_up_bloc.dart';
import 'views/sign_up_screen.dart';

class SignUpRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        //: Update route name
        RouteList.signUp: (context) {
          return BlocProvider(
            create: (context) => SignUpBloc(),
            child: const SignUpScreen(),
          );
        },
      };
}
