part of 'phone_number_screen.dart';

extension PhoneNumberAction on _PhoneNumberScreenState {
  void _blocListener(BuildContext context, PhoneNumberState state) {}

  void onSignIn() {
    if (validate() == true) {
      bloc.add(SignInByPhoneNumberEvent(
        phoneNumber: _phoneController.text!,
        password: _passwordController.text!,
      ));
    }
  }

  bool validate() {
    if (_phoneController.text?.isEmpty == true ||
        !_phoneController.text!.isValidPhoneNumber()) {
      _phoneController.setError(trans.invalidPhoneNumber);
      return false;
    }

    if (_passwordController.text?.isEmpty == true ||
        _passwordController.text?.isValidPassword == false) {
      _passwordController.setError(trans.invalidPassword);
      return false;
    }
    return true;
  }

  void onForgotPassword() {
    Navigator.pushNamed(
      context,
      RouteList.resetPassword,
      arguments: ResetPasswordScreenArgs(phoneNumber: _phoneController.text),
    );
  }
}
