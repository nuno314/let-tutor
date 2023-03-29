part of 'home_page_screen.dart';

extension HomePageAction on _HomePageScreenState {
  void onRefresh() {
    provider.initialData();
  }

  void onLoading() {
    provider.loadMoreTutorList();
  }

  void onTapTutorFilter() {
    // Navigator.pushNamed(
    //   context,
    //   RouteList.tutorFilter,
    //   arguments: bloc.state.tutorFilter,
    // ).then((value) {
    //   hideKeyBoard();
    //   if (value != null) {
    //     bloc.add(FilterChangedEvent(value as TutorListFilter));
    //   }
    // });
  }

  void onTapBookCourse(Teacher tutor) {
    Navigator.pushNamed(
      context,
      RouteList.tutorDetail,
      arguments: TutorArgs(
        tutor: tutor,
        tutorId: tutor.userId,
      ),
    );
  }

  void onTapTutorFavorite(Teacher tutor) {
    // bloc.add(FavoriteTutorEvent(tutor.userId));
  }
}
