part of 'home_page_screen.dart';

extension HomePageAction on _HomePageScreenState {
  void _blocListener(
    BuildContext context,
    HomePageState state,
  ) {
    _refreshController
      ..refreshCompleted()
      ..loadComplete();
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
    );
  }
}
