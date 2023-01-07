import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:let_tutor/data/models/document.dart';
import 'package:let_tutor/data/models/payment.dart';
import 'package:let_tutor/presentation/common_widget/export.dart';
import 'package:let_tutor/presentation/common_widget/smart_refresher_wrapper.dart';
import 'package:let_tutor/presentation/route/route_list.dart';
import 'package:let_tutor/presentation/theme/shadow.dart';
import 'package:let_tutor/presentation/theme/theme_button.dart';
import 'package:let_tutor/presentation/theme/theme_color.dart';

import '../../../../generated/assets.dart';
import '../../../base/base.dart';
import '../../../extentions/extention.dart';
import '../bloc/schedule_bloc.dart';

part 'schedule.action.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends StateBase<ScheduleScreen> {
  final controller = RefreshController(initialRefresh: true);
  @override
  ScheduleBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  late AppLocalizations trans;

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    trans = translate(context);
    return BlocConsumer<ScheduleBloc, ScheduleState>(
      listener: _blocListener,
      builder: (context, state) {
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ..._buildListing(state),
                  ],
                ),
              )),
        );
      },
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
            style: textTheme.bodyText1?.copyWith(
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

  Widget _buildLatestBook(ScheduleState state) {
    if (state.documents.isEmpty) {
      return SizedBox();
    }
    return Column(
      children: [
        Text(
          trans.latestBook,
          style: textTheme.bodyText1,
        ),
        ...state.documents.map((e) => BookItem(e)).toList(),
      ],
    );
  }

  Widget BookItem(Document document) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: boxShadowlight,
        color: AppColor.white,
      ),
      child: Column(children: [
        Text(document.title ?? '--'),
      ]),
    );
  }

  List<Widget> _buildListing(ScheduleState state) {
    final bookings = state.schedules;
    return [
      _buildTitle(),
      _buildLatestBook(state),
      if (bookings.isEmpty) ...[
        const SizedBox(
          height: 32,
        ),
        SvgPicture.asset(
          Assets.svg.icEmptySchedule,
        ),
        Text(
          trans.noSession,
          style: textTheme.bodyText2?.copyWith(
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
