import 'package:flutter/material.dart';
import 'package:let_tutor/data/models/course.dart';
import 'package:let_tutor/presentation/common_widget/export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../common_widget/document_viewer/document_viewer_screen.dart';
import '../../../../extentions/extention.dart';
import '../../../../route/route_list.dart';
import '../../../../theme/theme_color.dart';

class CourseInfo extends StatefulWidget {
  final Course course;
  const CourseInfo({
    required this.course,
  });

  @override
  State<CourseInfo> createState() => _CourseInfoState();
}

class _CourseInfoState extends State<CourseInfo> {
  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  late AppLocalizations trans;

  Course get course => widget.course;

  List<Topic> get topics => widget.course.topics ?? [];

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    trans = translate(context);
    return ScreenForm(
      trans: trans,
      title: course.name,
      headerColor: AppColor.primaryColor,
      bgColor: AppColor.scaffoldColor,
      showHeaderImage: false,
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Text(
            trans.document,
            style: textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemBuilder: (context, index) => InkWell(
                onTap: () => onTapDocument(topics.elementAt(index)),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppColor.gray8C,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            topics.elementAt(index).name ?? '--',
                            style: textTheme.bodyText1?.copyWith(
                              color: AppColor.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              separatorBuilder: (context, index) => const SizedBox(
                height: 8,
              ),
              itemCount: topics.length,
            ),
          ),
        ],
      ),
    );
  }

  void onTapDocument(Topic topic) {
    final link = topic.fileUrl?.replaceAll(' ', '%20') ??
        topic.nameFile?.replaceAll(' ', '%20') ??
        '';

    if (link.isNotEmpty) {
      Navigator.pushNamed(
        context,
        RouteList.documentViewer,
        arguments: DocumentViewerArgs(
          title: topic.name ?? trans.document,
          url: link,
        ),
      );
    }
  }
}
