part of '../tutor_screen.dart';

extension BookingPage on _TutorScreenState {
  Widget _buildBookingPage(TutorState state) {
    final schedules = state.schedules;

    return SmartRefresherWrapper.build(
      controller: bookingRefreshController,
      onRefresh: onRefreshBooking,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomScrollView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Text(
                    trans.availableTutoringTime,
                    style: textTheme.bodyText1,
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: onTapScheduleFilter,
                    icon: Icon(
                      Icons.filter_alt,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Text(
                state.filter.dateRangeToString(context),
                style: textTheme.bodyText2?.copyWith(fontSize: 12),
              ),
            ),
            SliverToBoxAdapter(
                child: SizedBox(
              height: 16,
            )),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8.0,
                  ),
                  child: ScheduleItem(
                    schedule: schedules.elementAt(
                      index,
                    ),
                    textTheme: textTheme,
                    trans: trans,
                    onTapBooking: () =>
                        onTapBooking(schedules.elementAt(index)),
                  ),
                ),
                childCount: schedules.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
