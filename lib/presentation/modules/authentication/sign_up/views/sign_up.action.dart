part of 'sign_up_screen.dart';

extension SignUpAction on _SignUpScreenState {
  void _blocListener(BuildContext context, SignUpState state) {
    if (state is RegisterAccountSuccess) {
      hideLoading();
      showNoticeDialog(
        context: context,
        message: trans.registerSuccessfully,
        title: trans.inform,
        titleBtn: trans.confirm,
        onClose: onCloseErrorDialog,
      );
    }
  }

  void onSignIn() {
    Navigator.pop(context);
  }

  void onSignUp() {
    if (validate() == false) {
      return;
    }

    showLoading();
    bloc.add(
      SignUpByEmailEvent(
        email: _emailController.text!,
        password: _passwordController.text!,
      ),
    );
  }

  bool validate() {
    if (_emailController.text?.isEmpty == true ||
        _emailController.text?.isEmail() == false) {
      _emailController.setError(trans.invalidEmail);
      return false;
    }
    if (_passwordController.text?.isEmpty == true ||
        _passwordController.text?.isValidPassword == false) {
      _passwordController.setError(trans.invalidPassword);
      return false;
    }
    if (_verifyPasswordController.text != _passwordController.text) {
      _verifyPasswordController.setError(trans.passwordNotMatch);
      return false;
    }
    return true;
  }
}
