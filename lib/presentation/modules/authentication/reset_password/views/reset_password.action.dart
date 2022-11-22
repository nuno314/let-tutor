part of 'reset_password_screen.dart';

extension ResetPasswordAction on _ResetPasswordScreenState {
  void _blocListener(BuildContext context, ResetPasswordState state) {
    if (state is ResponseState) {
      hideLoading();
      showNoticeDialog(
        context: context,
        message: trans.emailSendSuccess,
        title: trans.inform,
        titleBtn: trans.confirm,
        onClose: onCloseErrorDialog,
      );
    }
  }

  void onSubmitEmail() {
    if (validate() == false) {
      return;
    }
    showLoading();
    if (isEmail)
      bloc.add(ResetByEmailEvent(_emailController.text ?? ''));
    else
      bloc.add(
        ResetByPhoneNumberEvent(
          _phoneNumberController.text!,
        ),
      );
  }

  bool validate() {
    if (isEmail) {
      final email = _emailController.text;
      if (email?.isEmpty == true || email?.isEmail() == false) {
        _emailController.setError(trans.invalidEmail);
        return false;
      }
    } else {
      final phoneNumber = _phoneNumberController.text;

      if (phoneNumber?.isEmpty == true ||
          phoneNumber?.validVNPhoneNumber() == false) {
        _phoneNumberController.setError(trans.invalidEmail);
        return false;
      }
    }
    return true;
  }
}
