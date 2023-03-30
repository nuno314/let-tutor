part of 'home_page_screen.dart';

extension HomePageAction on _HomePageScreenState {
  void onRefresh() async {
    await provider.initialData();
    _refreshController.refreshCompleted();
  }

  void onLoading() {
    provider.loadMoreTutorList();
  }

  void onTapTutorFilter(HomePageState state) {
    Navigator.pushNamed(
      context,
      RouteList.tutorFilter,
      arguments: state.filter,
    ).then((value) {
      print(value);
      if (value != null && value is TutorListFilter) {
        provider.applyFilter(value);
        _refreshController.requestRefresh();
      }
    });
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
