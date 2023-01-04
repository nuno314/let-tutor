import 'dart:math';

import 'package:flutter/material.dart';
import 'package:let_tutor/common/constants.dart';
import 'package:let_tutor/domain/entities/date_range.entity.dart';
import 'package:let_tutor/domain/entities/tutor_list_filter.entity.dart';
import 'package:let_tutor/presentation/common_widget/export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../domain/entities/schedule_filter.entity.dart';
import '../../../../generated/assets.dart';
import '../../../common_widget/box_color.dart';
import '../../../common_widget/date_picker/calendar_date_picker.dart';
import '../../../extentions/extention.dart';
import '../../../theme/theme_button.dart';
import '../../../theme/theme_color.dart';

class ScheduleFilterScreen extends StatefulWidget {
  final ScheduleFilter filter;
  const ScheduleFilterScreen({
    required this.filter,
  });

  @override
  State<ScheduleFilterScreen> createState() => _ScheduleFilterScreenState();
}

class _ScheduleFilterScreenState extends State<ScheduleFilterScreen> {
  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  late AppLocalizations trans;

  late DateTime? from = widget.filter.from;
  late DateTime? to = widget.filter.to;

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    trans = translate(context);

    return ScreenForm(
      headerColor: AppColor.primaryColor,
      bgColor: AppColor.scaffoldColor,
      title: trans.schedule,
      showHeaderImage: false,
      trans: trans,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTutorFilters(),
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
                Navigator.pop(
                  context,
                  widget.filter.copyWithNullable(),
                );
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
                    dateRange: DateRange(
                      from: from,
                      to: to,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTutorFilters() {
    return Column(
      children: [
        _buildStudyFilter(),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _buildStudyFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
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
}
