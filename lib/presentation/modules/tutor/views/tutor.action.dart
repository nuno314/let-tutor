part of 'tutor_screen.dart';

extension TutorAction on _TutorScreenState {
  void _blocListener(BuildContext context, TutorState state) {
    hideLoading();
  }

  void onRefresh() {
    bloc.add(GetDataEvent());
  }

  void loadMore() {
    bloc.add(LoadMoreDataEvent());
  }
}
