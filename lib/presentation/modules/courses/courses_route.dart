import 'package:flutter/material.dart';
import 'package:let_tutor/data/models/course.dart';
import 'package:let_tutor/domain/entities/courses_filter.entity.dart';
import 'package:let_tutor/presentation/modules/courses/views/filter/courses_filter_screen.dart';
import 'package:let_tutor/presentation/modules/courses/views/info/course_info.dart';

import '../../common_widget/document_viewer/document_viewer_screen.dart';
import '../../route/route_list.dart';
import 'views/courses_screen.dart';

class CoursesRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        '': (context) => CoursesScreen(),
        RouteList.coursesFilter: (context) => CoursesFilterScreen(
              filter: settings.arguments as CoursesFilter,
            ),
        RouteList.documentViewer: (context) => DocumentViewerScreen(
              args: settings.arguments as DocumentViewerArgs,
            ),
        RouteList.courseDetail: (context) =>
            CourseInfo(course: settings.arguments as Course),
      };
}
