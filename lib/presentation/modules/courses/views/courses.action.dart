part of 'courses_screen.dart';

extension CoursesAction on _CoursesScreenState {
  void _blocListener(BuildContext context, CoursesState state) {
    _coursesRefreshController
      ..refreshCompleted()
      ..loadComplete();
    _eBooksRefreshController
      ..refreshCompleted()
      ..loadComplete();
    _interactiveEBooksRefreshController
      ..refreshCompleted()
      ..loadComplete();
    if (state is CoursesFilterInitial) {
      _coursesRefreshController.requestRefresh();
    }
  }

  void onCoursesRefresh() {
    bloc.add(GetCoursesEvent());
  }

  void onCoursesLoading() {
    bloc.add(LoadMoreCoursesEvent());
  }

  void onEBooksRefresh() {
    bloc.add(GetEBooksEvent());
  }

  void onEBooksLoading() {
    bloc.add(LoadMoreEBooksEvent());
  }

  void onInteractiveEBooksRefresh() {
    bloc.add(GetInteractiveEBooksEvent());
  }

  void onInteractiveEBooksLoading() {
    bloc.add(LoadMoreInteractiveEBooksEvent());
  }
}
