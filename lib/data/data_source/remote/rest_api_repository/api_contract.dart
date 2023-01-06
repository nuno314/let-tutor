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
  static const String userInfo = 'user/info';
  static const String changePassword = 'auth/change-password';
  static const String paymentHistory = 'payment/history';
  static const String paymentStatistics = 'payment/statistics';
  static const String referrals = 'user/referrals';
  static const String tutorList = 'tutor/search';
  static const String nextBookingSchedule = 'booking/next';
  static const String favoriteTutor = 'user/manageFavoriteTutor';
  static const String schedule =
      'schedule?tutorId={tutorId}&startTimestamp={startTimestamp}&endTimestamp={endTimestamp}';
  static const String booking = 'booking';
  static const String tutorFeedback =
      'feedback/v2/{tutorId}?page={page}&perPage={perPage}';
  static const String bookedSchedule =
      'booking/list/student?page={page}&perPage={perPage}&dateTimeGte={from}&orderBy=meeting&sortBy=asc';
  static const String deleteBookedSchedule = 'booking/schedule-detail';
}
