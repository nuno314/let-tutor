import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/data/models/payment.dart';

import '../../route/route_list.dart';
import 'bloc/meeting_bloc.dart';
import 'views/meeting_screen.dart';

class MeetingRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        RouteList.meeting: (context) {
          return BlocProvider(
            create: (context) => MeetingBloc(
              settings.arguments as BookingInfo,
            ),
            child: const MeetingScreen(),
          );
        },
      };
}
