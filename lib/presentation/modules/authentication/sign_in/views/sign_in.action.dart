part of 'sign_in_screen.dart';

extension SignInAction on _SignInScreenState {
  void _blocListener(BuildContext context, SignInState state) {
    if (state is LoginSuccessState) {
      Navigator.of(context).pushReplacementNamed(
        RouteList.dashboard,
      );
    }

    // if (state is LoginFailedState) {
    //   showErrorDialog(trans.incorrectEmailOrPassword);
    // }
  }

  void onSignIn(String? email, String? password) {
    if (validateAccount() == false) {
      return;
    }
    showLoading();
    bloc.add(SignInByEmailEvent(
      email: email,
      password: password,
    ));
  }

  void onSignUp() {
    Navigator.pushNamed(context, RouteList.signUp);
  }

  void onLoginWithGoogle() {}

  void onLoginWithFacebook() {
    FacebookAuth.instance.login(
      permissions: ['public_profile', 'email'],
    ).then(
      (value) {
        if (value.accessToken?.token != null) {
          bloc.add(
            SignInByFacebookEvent(
              accessToken: value.accessToken!.token,
            ),
          );
        }
        FacebookAuth.instance.getUserData().then(
          (value) async {
            print(value);
          },
        );
      },
    );
  }

  void onLoginWithPhoneNumber() {
    Navigator.pushNamed(context, RouteList.signInByPhoneNumber);
  }

  void onResetPassword() {
    Navigator.pushNamed(context, RouteList.resetPassword);
  }

  bool validateAccount() {
    if (_emailController.text?.isEmpty == true) {
      _emailController.setError(trans.emptyEmail);
      return false;
    }

    if (_emailController.text?.isEmail() == false) {
      _emailController.setError(trans.invalidEmail);
      return false;
    }
    if (_passwordController.text?.isEmpty == true) {
      _passwordController.setError(trans.emptyPassword);
      return false;
    }

    return true;
  }
}
