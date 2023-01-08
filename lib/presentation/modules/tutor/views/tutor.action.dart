part of 'tutor_screen.dart';

extension TutorAction on _TutorScreenState {
  void _blocListener(BuildContext context, TutorState state) {
    hideLoading();

    if (state is FilterChangedState || state is BookScheduleSuccessfulState) {
      bookingRefreshController.requestRefresh();
    } else if (state is FeedbackState) {
      Navigator.pushNamed(context, RouteList.feedback,
          arguments: state.feedbacks);
    } else if (state is GetTutorState) {
      print(state.tutor?.video);
      vpController.dispose();
      vpController = VideoPlayerController.network(
        tutor.video ?? '',
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );
      vpController.addListener(() {});
      vpController.setLooping(true);
      vpController.initialize();
    }
  }

  void onRefresh() {
    bloc.add(GetTutorInfoEvent(
      id: tutor.userId ?? '',
    ));
  }

  void onRefreshBooking() {
    bloc.add(GetScheduleByTutorIdEvent(
      widget.args.tutorId ?? '',
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

  void _onTapFavorite() {
    bloc.add(FavoriteTeacherEvent());
  }

  void onTapBooking(Schedule schedule) async {
    showLoading();

    final wallet =
        await injector.get<AppApiService>().client.getUserInfomation({}).then(
      (value) => value?.user?.wallet,
    );
    hideLoading();
    if (wallet != null)
      Navigator.pushNamed(
        context,
        RouteList.payment,
        arguments: PaymentArgs(
          wallet: wallet,
          schedule: schedule,
          tutor: widget.args.tutor ?? bloc.state.tutor!,
        ),
      ).then((value) {
        if (value is PaymentResult) if (value.res == true)
          bloc.add(
            BookScheduleEvent(schedule, value.note),
          );
      });
  }

  void _onTapReviews() {
    showLoading();
    bloc.add(GetReviewsEvent());
  }
}
