import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/presentation/modules/authentication/sign_in/views/phone_number_sign_in_screen.dart';
import 'package:let_tutor/presentation/route/route_list.dart';

import 'bloc/sign_in_bloc.dart';
import 'views/sign_in_screen.dart';

class SignInRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        RouteList.signIn: (context) {
          return BlocProvider(
            create: (context) => SignInBloc(),
            child: const SignInScreen(),
          );
        },
        RouteList.signInByPhoneNumber: (context) {
          return PhoneNumberSignInScreen();
        },
      };
}
