part of 'home_page_screen.dart';

extension HomePageAction on _HomePageScreenState {
  void _blocListener(
    BuildContext context,
    HomePageState state,
  ) {
    if (state is FilterChangedState) {
      _refreshController.requestRefresh();
    } else {
      _refreshController
        ..refreshCompleted()
        ..loadComplete();
    }
  }

  void onRefresh() {
    bloc.add(GetDataEvent());
  }

  void onLoading() {
    bloc.add(LoadMoreDataEvent());
  }

  void onTapTutorFilter() {
    Navigator.pushNamed(
      context,
      RouteList.tutorFilter,
      arguments: bloc.state.tutorFilter,
    ).then((value) {
      if (value != null) {
        bloc.add(FilterChangedEvent(value as TutorListFilter));
      }
    });
  }

  void onTapTutorFavorite(Teacher tutor) {
    bloc.add(FavoriteTutorEvent(tutor.id));
  }
}
