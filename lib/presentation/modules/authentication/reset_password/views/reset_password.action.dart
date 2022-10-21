part of 'reset_password_screen.dart';

extension ResetPasswordAction on _ResetPasswordScreenState {
  void _blocListener(BuildContext context, ResetPasswordState state) {}

  void onSubmitEmail() {
    Navigator.pushNamed(context, RouteList.resetPasswordConfirm);
  }
}
