import 'dart:async';

import 'package:dio/dio.dart';
import 'package:let_tutor/data/data_source/remote/rest_api_repository/api_contract.dart';
import 'package:let_tutor/data/models/response.dart';
import 'package:retrofit/retrofit.dart';

import '../../../models/user.dart';

part 'rest_api_repository.g.dart';

///////////////////////////////////////////////////////////////////////
//                https://pub.dev/packages/retrofit                 //
// flutter pub run build_runner build --delete-conflicting-outputs //
////////////////////////////////////////////////////////////////////

@RestApi()
abstract class RestApiRepository {
  factory RestApiRepository(Dio dio, {String baseUrl}) = _RestApiRepository;

  @POST(ApiContract.registerByEmail)
  Future<ResponseData?> registerByEmail(@Body() Map<String, dynamic> body);

  @POST(ApiContract.authEmailLogin)
  Future<LoginResponse?> authEmailLogin(@Body() Map<String, dynamic> body);

  @POST(ApiContract.authPhoneNumberLogin)
  Future<LoginResponse?> authPhoneNumberLogin(
      @Body() Map<String, dynamic> body);

  @GET(ApiContract.verifyAccount)
  Future<LoginResponse?> verifyAccount(@Body() Map<String, dynamic> body);

  @POST(ApiContract.authGoogleLogin)
  Future<LoginResponse?> authGoogleLogin(@Body() Map<String, dynamic> body);

  @POST(ApiContract.authFacebookLogin)
  Future<LoginResponse?> authFacebookLogin(@Body() Map<String, dynamic> body);

  @POST(ApiContract.refreshToken)
  Future<LoginResponse?> refreshToken(@Body() Map<String, dynamic> body);

  @POST(ApiContract.registerByPhoneNumber)
  Future<LoginResponse?> registerByPhoneNumber(
      @Body() Map<String, dynamic> body);

  @POST(ApiContract.resendOTP)
  Future<ResponseData?> resendOTP(@Body() Map<String, dynamic> body);

  @POST(ApiContract.activatePhoneNumber)
  Future<LoginResponse?> activatePhoneNumber(@Body() Map<String, dynamic> body);

  @POST(ApiContract.forgotPassword)
  Future<ResponseData?> forgotPassword(@Body() Map<String, dynamic> body);

  @GET(ApiContract.userInfo)
  Future<ResponseData?> getUserInfomation(@Body() Map<String, dynamic> body);

  @PUT(ApiContract.userInfo)
  Future<ResponseData?> updateUserInfomation(@Body() Map<String, dynamic> body);

  @POST(ApiContract.changePassword)
  Future<ResponseData?> changePassword(@Body() Map<String, dynamic> body);

  @GET(ApiContract.paymentHistory)
  Future<PaymentResponseData?> getPaymentHistory();

  @GET(ApiContract.paymentStatistics)
  Future<PaymentResponseData?> getPaymentStatistics();

  @GET(ApiContract.referrals)
  Future<List<User>?> getReferrals();

  @GET(ApiContract.bookedClasses)
  Future<ScheduleResponseData> getBookedClasses({
    @Path() String page = '',
    @Path() String perPage = '',
    @Path() String from = '',
    @Path() String to = '',
    @Path() String orderBy = 'meeting',
    @Path() String sortBy = 'desc',
  });

  @GET(ApiContract.tutorList)
  Future<TutorResponseData> getTutorList({
    @Path() String page = '',
    @Path() String perPage = '',
  });
}
