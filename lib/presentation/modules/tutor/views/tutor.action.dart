part of 'tutor_screen.dart';

extension TutorAction on _TutorScreenState {
  void _blocListener(BuildContext context, TutorState state) {
    if (state is FilterChangedState) {
      bookingRefreshController.requestRefresh();
    }
    hideLoading();
  }

  void onRefresh() {
    bloc.add(GetDataEvent());
  }

  void loadMore() {
    bloc.add(LoadMoreDataEvent());
  }

  void onRefreshBooking() {
    bloc.add(GetScheduleByTutorIdEvent(
      tutor?.userId ?? '',
    ));
  }

  void onTapScheduleFilter() {
    Navigator.pushNamed(
      context,
      RouteList.scheduleFilter,
      arguments: bloc.state.filter,
    ).then((value) {
      if (value != null) {
        bloc.add(ApplyScheduleFilter(value as ScheduleFilter));
      }
    });
  }

  void _onTapFavorite() {}
}
