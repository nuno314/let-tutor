part of 'teacher_screen.dart';

extension TeacherAction on _TeacherScreenState {
  void _blocListener(BuildContext context, TeacherState state) {
    hideLoading();
  }

  void onRefresh() {
    bloc.add(GetDataEvent());
  }

  void loadMore() {
    bloc.add(LoadMoreDataEvent());
  }
}
