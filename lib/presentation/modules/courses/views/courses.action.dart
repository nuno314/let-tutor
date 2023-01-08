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
      _eBooksRefreshController.requestRefresh();
      _interactiveEBooksRefreshController.requestRefresh();
    } else if (state is ApplyCoursesFilterState) {
      _coursesRefreshController.requestRefresh();
    } else if (state is ApplyEBooksFilterState) {
      _eBooksRefreshController.requestRefresh();
    } else if (state is ApplyInteractiveEBooksFilterState) {
      _interactiveEBooksRefreshController.requestRefresh();
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

  void _getCoursesSearch(String? value) {
    bloc.add(
      ApplyCoursesFilterEvent(
        bloc.state.coursesFilter.copyWith(
          searchKey: value,
        ),
      ),
    );
  }

  void _getEBooksSearch(String? value) {
    bloc.add(
      ApplyEBooksFilterEvent(
        bloc.state.eBooksFilter.copyWith(
          searchKey: value,
        ),
      ),
    );
  }

  void _getInteractiveEBooksSearch(String? value) {
    bloc.add(
      ApplyInteractiveEBooksFilterEvent(
        bloc.state.interactiveEBooksFilter.copyWith(
          searchKey: value,
        ),
      ),
    );
  }

  void onTapFilter() {
    if (_pageController.page == 0) {
      Navigator.pushNamed(
        context,
        RouteList.coursesFilter,
        arguments: bloc.state.coursesFilter,
      ).then((value) {
        if (value is CoursesFilter) {
          bloc.add(ApplyCoursesFilterEvent(value));
        }
      });
    } else if (_pageController.page == 1) {
      Navigator.pushNamed(
        context,
        RouteList.coursesFilter,
        arguments: bloc.state.eBooksFilter,
      ).then((value) {
        if (value is CoursesFilter) {
          bloc.add(ApplyEBooksFilterEvent(value));
        }
      });
    } else if (_pageController.page == 2) {
      Navigator.pushNamed(
        context,
        RouteList.coursesFilter,
        arguments: bloc.state.interactiveEBooksFilter,
      ).then((value) {
        if (value is CoursesFilter) {
          bloc.add(ApplyInteractiveEBooksFilterEvent(value));
        }
      });
    }
  }

  void onTapCourse(Course course) {
    Navigator.pushNamed(
      context,
      RouteList.courseDetail,
      arguments: course,
    );
  }

  void onTapBook(Course book) async {
    final url = book.fileUrl!;
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}
