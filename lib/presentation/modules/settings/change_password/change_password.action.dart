part of 'change_password_screen.dart';

extension ChangePasswordAction on _ChangePasswordScreenState {
  void _blocListener(
    BuildContext context,
    ChangePasswordState state,
  ) {
    if (state is ChangePasswordSuccess) {
      hideLoading();
      Navigator.pop(context);
    }
  }

  bool validate() {
    if (_curController.text.isNullOrEmpty) {
      _curController.setError(trans.pleaseEnterPassword);
      return false;
    }

    if (_newController.text.isNullOrEmpty) {
      _newController.setError(trans.pleaseEnterPassword);
      return false;
    }

    if (_newController.text?.isValidPassword == false) {
      _newController.setError(trans.invalidPassword);
      return false;
    }

    if (_newController.text == _curController.text) {
      _newController.setError(trans.pleaseEnterNewPassword);
    }

    if (_verifyController.text != _newController.text) {
      _verifyController.setError(trans.passwordNotMatch);
      return false;
    }
    return true;
  }

  void onChangePassword() {
    if (validate() == true) {
      showLoading();
      bloc.add(
        ChangePasswordEventImpl(
          password: _curController.text!,
          newPassword: _newController.text!,
        ),
      );
    }
  }
}
