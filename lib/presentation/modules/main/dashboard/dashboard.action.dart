part of 'dashboard_screen.dart';

extension DashboardAction on _DashboardScreenState {
  Future<bool> onNavigationPressed(int idx) async {
    print('awd');
    _cubit.navigateTo(idx);
    return true;
  }

  void _didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      AppColor.setLightStatusBar();
    }
  }

  void _cubitListener(BuildContext context, DashboardState state) {
    print('awdd');
    print(state.index);
    if (state.lighStatusBar) {
      AppColor.setLightStatusBar();
    } else {
      AppColor.setDarkStatusBar();
    }
    _pageController.jumpToPage(
      state.index,
    );
  }
}
