class ApiContract {
  static const String logout = 'logout';
  static const String registerByEmail = 'auth/register';
  static const String authEmailLogin = 'auth/login';
  static const String authPhoneNumberLogin = 'auth/phone-login';
  static const String verifyAccount = 'auth/verifyAccount';
  static const String authGoogleLogin = 'auth/google';
  static const String authFacebookLogin = 'auth/facebook';
  static const String refreshToken = 'auth/refresh-token';
  static const String registerByPhoneNumber = 'auth/phone-register';
  static const String resendOTP = 'verify/phone-auth-verify/create';
  static const String activatePhoneNumber = 'verify/phone-auth-verify/activate';
  static const String forgotPassword = 'user/forgotPassword';
}
