part of '../tutor_screen.dart';

extension BookingPage on _TutorScreenState {
  Widget _buildBookingPage(TutorState state) {
    return SmartRefresherWrapper.build(
      controller: bookingRefreshController,
      onRefresh: onRefreshBooking,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
            const SizedBox(height: 8),
            Text(
              state.filter.dateRangeToString(context),
              style: textTheme.bodyText2?.copyWith(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
