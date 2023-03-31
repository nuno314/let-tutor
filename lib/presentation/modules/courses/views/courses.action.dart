part of 'courses_screen.dart';

extension CoursesAction on _CoursesScreenState {
  void hideLoading() {
    _coursesRefreshController
      ..refreshCompleted()
      ..loadComplete();
    _eBooksRefreshController
      ..refreshCompleted()
      ..loadComplete();
    _interactiveEBooksRefreshController
      ..refreshCompleted()
      ..loadComplete();
  }

  void onCoursesRefresh() async {
    await provider.getCoursesEvent();
    hideLoading();
  }

  void onCoursesLoading() async {
    await provider.loadMoreCoursesEvent();
    hideLoading();
  }

  void onEBooksRefresh() async {
    await provider.getEBooksEvent();
    hideLoading();
  }

  void onEBooksLoading() async {
    await provider.loadMoreEBooksEvent();
    hideLoading();
  }

  void onInteractiveEBooksRefresh() async {
    await provider.getInteractiveEBooksEvent();
    hideLoading();
  }

  void onInteractiveEBooksLoading() async {
    await provider.loadMoreInteractiveEBooksEvent();
    hideLoading();
  }

  void _getCoursesSearch(String? value) {
    //  provider.applyCoursesFilterEvent(
    //       bloc.state.coursesFilter.copyWith(
    //         searchKey: value,
    //       ),
    //     ),
    //   );
  }

  void _getEBooksSearch(String? value) {
    //  provider.applyEBooksFilterEvent(
    //       bloc.state.eBooksFilter.copyWith(
    //         searchKey: value,
    //       ),
    //     ),
    //   );
  }

  void _getInteractiveEBooksSearch(String? value) {
    //  provider.applyInteractiveEBooksFilterEvent(
    //       bloc.state.interactiveEBooksFilter.copyWith(
    //         searchKey: value,
    //       ),
    //     ),
    //   );
  }

  void onTapFilter() {
    // if (_pageController.page == 0) {
    //   Navigator.pushNamed(
    //     context,
    //     RouteList.coursesFilter,
    //     arguments: bloc.state.coursesFilter,
    //   ).then((value) {
    //     if (value is CoursesFilter) {
    //       bloc.add(ApplyCoursesFilterEvent(value));
    //     }
    //   });
    // } else if (_pageController.page == 1) {
    //   Navigator.pushNamed(
    //     context,
    //     RouteList.coursesFilter,
    //     arguments: bloc.state.eBooksFilter,
    //   ).then((value) {
    //     if (value is CoursesFilter) {
    //       bloc.add(ApplyEBooksFilterEvent(value));
    //     }
    //   });
    // } else if (_pageController.page == 2) {
    //   Navigator.pushNamed(
    //     context,
    //     RouteList.coursesFilter,
    //     arguments: bloc.state.interactiveEBooksFilter,
    //   ).then((value) {
    //     if (value is CoursesFilter) {
    //       bloc.add(ApplyInteractiveEBooksFilterEvent(value));
    //     }
    //   });
    // }
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
