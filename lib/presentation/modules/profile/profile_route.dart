import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/presentation/route/route_list.dart';

import '../../../data/models/user.dart';
import 'bloc/profile_bloc.dart';
import 'views/profile_screen.dart';

class ProfileRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        RouteList.profile: (context) {
          return BlocProvider(
            create: (context) => ProfileBloc(),
            child: ProfileScreen(
              user: User(
                name: 'Long Long',
                avatarUrl:
                    'https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1657037111897.jpg',
                id: 'f569c202-7bbf-4620-af77-ecc1419a6b28',
                email: 'student@lettutor.com',
                phoneNumber: '842499996508',
                phoneNumberValidate: true,
                dob: '1999-06-10',
                level: 'Pre A1 (Beginner)',
                wantToLearn: [
                  'Business English',
                  'Conversational English',
                ],
              ),
            ),
          );
        },
      };
}
