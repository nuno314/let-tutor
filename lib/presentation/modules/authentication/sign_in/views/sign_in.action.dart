part of 'sign_in_screen.dart';

extension SignInAction on _SignInScreenState {
  void _blocListener(BuildContext context, SignInState state) {}

  void onSignIn() {
    Navigator.pushNamed(context, RouteList.dashBoardRoute);
  }

  void onSignUp() {
    Navigator.pushNamed(context, RouteList.signUp);
  }

  void onLoginWithGoogle() {}

  void onLoginWithFacebook() {}

  void onLoginWithPhoneNumber() {}

  void onResetPassword() {
    Navigator.pushNamed(context, RouteList.resetPassword);
  }
}
