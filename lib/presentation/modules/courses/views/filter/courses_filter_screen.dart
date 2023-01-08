import 'dart:math';

import 'package:flutter/material.dart';
import 'package:let_tutor/common/constants.dart';
import 'package:let_tutor/data/models/course.dart';
import 'package:let_tutor/domain/entities/courses_filter.entity.dart';
import 'package:let_tutor/domain/entities/tutor_list_filter.entity.dart';
import 'package:let_tutor/presentation/common_widget/export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../common_widget/box_color.dart';
import '../../../../extentions/extention.dart';
import '../../../../theme/theme_button.dart';
import '../../../../theme/theme_color.dart';

class CoursesFilterScreen extends StatefulWidget {
  final CoursesFilter filter;
  const CoursesFilterScreen({
    required this.filter,
  });

  @override
  State<CoursesFilterScreen> createState() => _TutorFilterScreenState();
}

class _TutorFilterScreenState extends State<CoursesFilterScreen> {
  late final categories = <Category>[...widget.filter.categories];

  late final specialtiesFilter = Specialty.values;

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  late AppLocalizations trans;

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    trans = translate(context);
    return ScreenForm(
      headerColor: AppColor.primaryColor,
      bgColor: AppColor.scaffoldColor,
      title: trans.courses,
      showHeaderImage: false,
      trans: trans,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trans.selectCategory,
                    style: textTheme.bodyText1?.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  _buildCategoriesFilter(),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
          _buildBottomButtons(),
        ],
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.only(
        bottom: max(MediaQuery.of(context).padding.bottom, 16),
        right: 16,
        left: 16,
        top: 16,
      ),
      child: Row(
        children: [
          Expanded(
            child: ThemeButton.outline(
              context: context,
              title: trans.reset,
              onPressed: () {
                Navigator.pop(context, widget.filter.copyWithNullable());
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ThemeButton.primary(
              context: context,
              title: trans.apply,
              onPressed: () {
                Navigator.pop(
                  context,
                  widget.filter.copyWith(
                    categories: categories,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesFilter() {
    return Wrap(
      children: [
        ...widget.filter.categoriesFilter.map(_buildCategoryItem),
      ],
    );
  }

  Widget _buildCategoryItem(Category e) {
    final selected = categories.contains(e);
    return Padding(
      padding: const EdgeInsets.only(right: 12, top: 12),
      child: ChipItem(
        onTap: (selected) {
          setState(() {
            var gs = <Category>[];
            if (selected) {
              gs = [...categories..removeWhere((element) => element == e)];
            } else if (!selected) {
              gs = [...categories, e];
            } else {
              gs = [...categories];
            }

            categories
              ..clear()
              ..addAll(gs);
          });
        },
        text: e.title ?? '--',
        selected: selected,
        textTheme: textTheme,
      ),
    );
  }
}
