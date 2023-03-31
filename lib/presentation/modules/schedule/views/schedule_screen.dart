import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:let_tutor/data/models/payment.dart';
import 'package:let_tutor/presentation/common_widget/export.dart';
import 'package:let_tutor/presentation/common_widget/smart_refresher_wrapper.dart';
import 'package:let_tutor/presentation/modules/schedule/provider/schedule_provider.dart';
import 'package:let_tutor/presentation/route/route_list.dart';
import 'package:let_tutor/presentation/theme/theme_button.dart';
import 'package:let_tutor/presentation/theme/theme_color.dart';

import '../../../../generated/assets.dart';
import '../../../extentions/extention.dart';

part 'schedule.action.dart';

class ScheduleScreen extends ConsumerStatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends ConsumerState<ScheduleScreen> {
  final controller = RefreshController(initialRefresh: true);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  late AppLocalizations trans;

  late ScheduleProvider provider;

  @override
  void initState() {
    provider = ref.read(scheduleProvider.notifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    trans = translate(context);
    final state = ref.watch(scheduleProvider);
    return ScreenForm(
      headerColor: AppColor.primaryColor,
      bgColor: AppColor.scaffoldColor,
      showHeaderImage: false,
      showBackButton: false,
      trans: trans,
      title: trans.bookingTime,
      child: SmartRefresherWrapper.build(
          controller: controller,
          enablePullUp: state.canLoadMore,
          onRefresh: onRefresh,
          onLoading: onLoading,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                ..._buildListing(state),
              ],
            ),
          )),
    );
  }

  Widget _buildTitle() {
    return Center(
      child: Column(
        children: [
          SvgPicture.asset(
            Assets.svg.icBooking,
            width: 100,
            height: 100,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            trans.schedule,
            style: textTheme.bodyLarge?.copyWith(
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    return ThemeButton.bottomButton(
      context,
      isWithShadown: false,
      buttonTitle: trans.bookALesson,
      padding: const EdgeInsets.all(0),
      onTap: onBookSchedule,
    );
  }

  List<Widget> _buildListing(ScheduleState state) {
    final bookings = state.schedules;
    return [
      _buildTitle(),
      if (bookings.isEmpty) ...[
        const SizedBox(
          height: 32,
        ),
        SvgPicture.asset(
          Assets.svg.icEmptySchedule,
        ),
        Text(
          trans.noSession,
          style: textTheme.bodyMedium?.copyWith(
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 150,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Wrap(children: [_buildBottomButton(context)]),
        ),
      ],
      ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => BookingInfoItem(
          booking: bookings.elementAt(index),
          textTheme: textTheme,
          trans: trans,
          onTapCancel: () => onTapCancel(bookings.elementAt(index)),
          onTapJoinMeeting: () => onTapJoinMeeting(bookings.elementAt(index)),
        ),
        separatorBuilder: (context, index) => const SizedBox(
          height: 8,
        ),
        itemCount: bookings.length,
      ),
    ];
  }
}
