part of 'account_screen.dart';

extension AccountAction on _AccountScreenState {
  void _blocListener(BuildContext context, AccountState state) {}

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
