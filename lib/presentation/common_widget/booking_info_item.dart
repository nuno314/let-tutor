import 'package:flutter/material.dart';
import 'package:let_tutor/common/utils.dart';
import 'package:let_tutor/data/models/payment.dart';
import 'package:let_tutor/data/models/teacher.dart';
import 'package:let_tutor/presentation/common_widget/export.dart';
import 'package:let_tutor/presentation/theme/shadow.dart';
import 'package:let_tutor/presentation/theme/theme_button.dart';
import 'package:let_tutor/presentation/theme/theme_color.dart';

class BookingInfoItem extends StatelessWidget {
  final BookingInfo booking;
  final TextTheme textTheme;
  final dynamic trans;
  final void Function() onTapCancel;
  final void Function() onTapJoinMeeting;
  BookingInfoItem({
    required this.booking,
    required this.textTheme,
    required this.trans,
    required this.onTapCancel,
    required this.onTapJoinMeeting,
  });

  Teacher? get tutor => booking.schedule?.scheduleInfo?.tutorInfo;
  final controller = InputContainerController();
  DateTime get startDateTime => DateTime.fromMillisecondsSinceEpoch(
        booking.schedule!.startPeriodTimestamp ?? 0,
      );
  DateTime get endDateTime => DateTime.fromMillisecondsSinceEpoch(
        booking.schedule!.endPeriodTimestamp ?? 0,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: boxShadowlight,
          color: AppColor.white,
          borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          _buildTitle(context),
          Divider(
            height: 32,
            thickness: 1,
          ),
          _buildInfo(context),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              startDateTime.toDateWithWeekdayFormat(context),
              style: textTheme.bodyText1,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              startDateTime.toTimeFormat() + ' - ' + endDateTime.toTimeFormat(),
              style: textTheme.bodyText2?.copyWith(
                fontSize: 12,
                color: AppColor.gray8C,
              ),
            ),
          ],
        ),
        const Spacer(),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: CachedNetworkImageWrapper.avatar(
            url: tutor?.avatar ?? '',
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Column(
          children: [
            Text(
              tutor?.name ?? '--',
              style: textTheme.bodyText1?.copyWith(),
            )
          ],
        ),
      ],
    );
  }

  Widget _buildInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (booking.studentRequest.isNotNullOrEmpty) ...[
          Text(
            booking.studentRequest!,
            style: textTheme.bodyText2?.copyWith(fontSize: 14),
          ),
          const SizedBox(
            height: 8,
          ),
        ],
        Row(
          children: [
            if (DateTime.now()
                .add(const Duration(hours: 2))
                .isBefore(startDateTime)) ...[
              Expanded(
                child: ThemeButton.outline(
                  context: context,
                  title: trans.cancel,
                  constraints: BoxConstraints(minHeight: 40, maxHeight: 40),
                  onPressed: onTapCancel,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
            ],
            Expanded(
              child: ThemeButton.primary(
                context: context,
                title: trans.goToMeeting,
                constraints: BoxConstraints(minHeight: 40, maxHeight: 40),
                onPressed: onTapJoinMeeting,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
