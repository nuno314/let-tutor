part of 'histories_screen.dart';

extension HistoriesAction on _HistoriesScreenState {
  void _blocListener(BuildContext context, HistoriesState state) {
    hideLoading();
  }

  void onRefresh() {
    bloc.add(GetDataEvent());
  }

  void loadMore() {
    bloc.add(LoadMoreDataEvent());
  }
}
