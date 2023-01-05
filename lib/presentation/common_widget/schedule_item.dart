import 'package:flutter/material.dart';
import 'package:let_tutor/common/utils.dart';
import 'package:let_tutor/data/models/schedule.dart';
import 'package:let_tutor/presentation/common_widget/box_color.dart';
import 'package:let_tutor/presentation/theme/shadow.dart';
import 'package:let_tutor/presentation/theme/theme_color.dart';

class ScheduleItem extends StatelessWidget {
  final Schedule schedule;
  final TextTheme textTheme;
  final dynamic trans;
  final void Function() onTapBooking;
  const ScheduleItem({
    required this.schedule,
    required this.textTheme,
    required this.trans,
    required this.onTapBooking,
  });

  Color get color => schedule.isBooked == true ? Colors.red : Colors.green;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        boxShadow: boxShadowlight,
        color: schedule.isBooked == true ? Colors.red : Colors.green,
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            color,
            Colors.white,
          ],
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        _buildTitle(context),
        if (schedule.isBooked == false) ...[
          Divider(
            height: 8,
            thickness: 1,
            color: AppColor.white,
          ),
          _buildButton(),
        ]
      ]),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Row(
      children: [
        Text(
          DateTime.fromMillisecondsSinceEpoch(
            schedule.startPeriodTimestamp ?? 0,
          ).toLocal().toDateWithWeekdayFormat(context),
          style: textTheme.bodyText1?.copyWith(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        const Spacer(),
        Text(
          DateTime.fromMillisecondsSinceEpoch(
                schedule.startPeriodTimestamp ?? 0,
              ).toLocal().toTimeFormat() +
              ' - ' +
              DateTime.fromMillisecondsSinceEpoch(
                schedule.endPeriodTimestamp ?? 0,
              ).toLocal().toTimeFormat(),
          style: textTheme.bodyText1?.copyWith(
            fontSize: 14,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildButton() {
    return InkWell(
      onTap: onTapBooking,
      child: BoxColor(
        color: color,
        child: Text(
          trans.book,
          style: textTheme.bodyText1?.copyWith(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
