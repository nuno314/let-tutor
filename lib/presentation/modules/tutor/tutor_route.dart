import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/domain/entities/schedule_filter.entity.dart';
import 'package:let_tutor/domain/entities/tutor_list_filter.entity.dart';
import 'package:let_tutor/presentation/modules/tutor/views/feedback/tutor_feedback_screen.dart';
import 'package:let_tutor/presentation/modules/tutor/views/filter/schedule_filter_screen.dart';
import 'package:let_tutor/data/models/teacher.dart' as fb;
import 'package:let_tutor/presentation/modules/tutor/views/filter/tutor_filter_screen.dart';

import '../../route/route_list.dart';
import 'bloc/tutor_bloc.dart';
import 'views/payment/payment_screen.dart';
import 'views/tutor_screen.dart';

class TutorRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        RouteList.tutorDetail: (context) {
          final args = settings.arguments as TutorArgs;
          return BlocProvider(
            create: (context) => TutorBloc(args.tutor),
            child: TutorScreen(
              args: args,
            ),
          );
        },
        RouteList.tutorFilter: (context) {
          return TutorFilterScreen(
            filter: settings.arguments as TutorListFilter,
          );
        },
        RouteList.scheduleFilter: (context) => ScheduleFilterScreen(
              filter: settings.arguments as ScheduleFilter,
            ),
        RouteList.payment: (context) =>
            PaymentScreen(args: settings.arguments as PaymentArgs),
        RouteList.feedback: (context) =>
            FeedbackScreen(feedbacks: settings.arguments as List<fb.Feedback>),
      };
}
