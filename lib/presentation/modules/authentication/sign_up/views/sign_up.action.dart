part of 'sign_up_screen.dart';

extension SignUpAction on _SignUpScreenState {
  void _blocListener(BuildContext context, SignUpState state) {}

  void onSignIn() {
    Navigator.pop(context);
  }

  void onSingUp() {}

  void onLoginWithGoogle() {}

  void onLoginWithFacebook() {}

  void onLoginWithPhoneNumber() {}
}
