import 'dart:math';

import 'package:flutter/material.dart';
import 'package:let_tutor/domain/entities/tutor_list_filter.entity.dart';
import 'package:let_tutor/presentation/common_widget/export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../generated/assets.dart';
import '../../../common_widget/box_color.dart';
import '../../../common_widget/date_picker/calendar_date_picker.dart';
import '../../../extentions/extention.dart';
import '../../../theme/theme_button.dart';
import '../../../theme/theme_color.dart';

class TutorFilterScreen extends StatefulWidget {
  final TutorListFilter filter;
  const TutorFilterScreen({
    super.key,
    required this.filter,
  });

  @override
  State<TutorFilterScreen> createState() => _TutorFilterScreenState();
}

class _TutorFilterScreenState extends State<TutorFilterScreen> {
  late List<String> categoriesFilter;
  late final categories = <String>[...widget.filter.categories];

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  late AppLocalizations trans;

  late DateTime? from = widget.filter.from;
  late DateTime? to = widget.filter.to;

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    trans = translate(context);
    categoriesFilter = [
      trans.all,
      trans.englishForKids,
      trans.englishForBusiness,
      trans.conversational,
      trans.starters,
      trans.movers,
      trans.flyers,
      trans.ket,
      trans.pet,
      trans.ielts,
      trans.toefl,
      trans.toeic,
    ];
    return ScreenForm(
      headerColor: AppColor.primaryColor,
      bgColor: AppColor.scaffoldColor,
      title: trans.tutorFilter,
      showHeaderImage: false,
      trans: trans,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  _buildTutorFilters(),
                  _buildGroupFilter(),
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
                Navigator.pop(context, widget.filter.copyWith());
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
                  widget.filter.copyWith(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTutorFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          _buildStudyFilter(),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildStudyFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          trans.selectAvailableTutoringTime,
          style: textTheme.bodyText1?.copyWith(
            fontSize: 14,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        DateInputCalendarPicker(
          onDateSelected: (date) {
            from = date;
          },
          hint: trans.selectDate,
          monthStr: trans.month,
          title: trans.fromDate,
          initial: from,
          calendarIcon: Assets.svg.icCalendar,
        ),
        const SizedBox(height: 12),
        DateInputCalendarPicker(
          onDateSelected: (date) {
            to = date;
          },
          hint: trans.selectDate,
          monthStr: trans.month,
          title: trans.toDate,
          initial: to,
          calendarIcon: Assets.svg.icCalendar,
        ),
      ],
    );
  }

  Widget _buildGroupFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Wrap(
        children: [
          ...categoriesFilter.map(_buildCategoryItem),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String e) {
    final selected = categories.contains(e);
    return Padding(
      padding: const EdgeInsets.only(right: 12, top: 12),
      child: ChipItem(
        onTap: (selected) {
          setState(() {
            var gs = <String>[];
            if (selected) {
              if (e == trans.all) {
                gs.clear();
              } else {
                gs = [...categories..removeWhere((element) => element == e)];
              }
            } else if (!selected) {
              if (e == trans.all) {
                gs = [...categoriesFilter];
              } else {
                gs = [...categories, e];
              }
            } else {
              gs = [...categories];
            }

            categories
              ..clear()
              ..addAll(gs);
            print(categories);
          });
        },
        text: e,
        selected: selected,
        textTheme: textTheme,
      ),
    );
  }
}
