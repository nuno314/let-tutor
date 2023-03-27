import 'package:flutter/material.dart';
import 'package:let_tutor/common/utils.dart';
import 'package:let_tutor/data/models/course.dart';
import 'package:let_tutor/presentation/theme/theme_color.dart';

import 'box_color.dart';
import 'cache_network_image_wrapper.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  final ThemeData themeData;
  final void Function(Course) onTap;
  final String? viewNowText;
  final Color? borderColor;
  final double aspectRatio;
  final bool isBook;

  const CourseCard({
    Key? key,
    required this.course,
    required this.themeData,
    required this.onTap,
    required this.aspectRatio,
    this.viewNowText,
    this.borderColor,
    this.isBook = false,
  }) : super(key: key);

  bool get canClick => !isBook || course.fileUrl?.isNotNullOrEmpty == true;

  @override
  Widget build(BuildContext context) {
    final textTheme = themeData.textTheme;
    return HighlightBoxColor(
      borderColor: borderColor,
      onTap: canClick ? () => onTap(course) : null,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: aspectRatio,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImageWrapper.item(
                url: course.imageUrl ?? '',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    course.name ?? '--',
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (canClick)
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColor.primaryColor,
                    ),
                    child: Center(
                      child: Text(
                        viewNowText ?? '--',
                        textAlign: TextAlign.center,
                        style: textTheme.bodyLarge?.copyWith(
                          color: AppColor.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
