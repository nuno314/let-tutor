import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/presentation/modules/authentication/phone_number/bloc/phone_number_bloc.dart';
import 'package:let_tutor/presentation/modules/authentication/phone_number/views/phone_number_screen.dart';
import 'package:let_tutor/presentation/modules/authentication/sign_in/bloc/sign_in_bloc.dart';
import 'package:let_tutor/presentation/modules/authentication/sign_in/views/sign_in_screen.dart';
import 'package:let_tutor/presentation/modules/authentication/sign_up/bloc/sign_up_bloc.dart';
import 'package:let_tutor/presentation/modules/authentication/sign_up/views/sign_up_screen.dart';
import 'package:let_tutor/presentation/route/route_list.dart';

class AuthenticationRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        RouteList.signIn: (context) {
          return BlocProvider(
            create: (context) => SignInBloc(),
            child: const SignInScreen(),
          );
        },
        RouteList.signInByPhoneNumber: (context) {
          return BlocProvider(
            create: (context) => PhoneNumberBloc(),
            child: const PhoneNumberScreen(),
          );
        },
        RouteList.signUp: (context) {
          return BlocProvider(
            create: (context) => SignUpBloc(),
            child: const SignUpScreen(),
          );
        },
      };
}
