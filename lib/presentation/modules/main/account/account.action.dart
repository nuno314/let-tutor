part of 'account_screen.dart';

extension AccountAction on _AccountScreenState {
  void _blocListener(BuildContext context, AccountState state) {
    _refreshController
      ..refreshCompleted()
      ..loadComplete();
  }

  void onRefresh() {
    bloc.add(GetDataEvent());
  }

  void onProfile() {
    Navigator.pushNamed(context, RouteList.profile).then((value) {
      if (value is User) {
        _refreshController.requestRefresh();
      }
    }).then((value) => hideKeyBoard());
  }

  void onMyWallet() {
    Navigator.pushNamed(
      context,
      RouteList.wallet,
    ).then((value) => hideKeyBoard());
  }

  void onSettings() {
    Navigator.pushNamed(
      context,
      RouteList.settings,
    ).then((value) => hideKeyBoard());
  }

  void onBecomeATutor() {
    Navigator.pushNamed(
      context,
      RouteList.registerTutor,
    ).then((value) => hideKeyBoard());
  }

  void logout() {
    doLogout().then(
      (value) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RouteList.signIn,
          (_) => false,
        );
      },
    );
  }
}
