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

  @POST(ApiContract.tutorList)
  Future<TutorResponse> getTutorList({
    @Field() int page = 1,
    @Field() int perPage = 12,
    @Field() String? search,
    @Field() Map<String, dynamic>? filters,
  });

  @GET(ApiContract.nextBookingSchedule)
  Future<ScheduleResponseData> getNextBookingSchedule({
    @Field() String? dateTime,
  });

  @POST(ApiContract.favoriteTutor)
  Future<ManageResponse> favoriteTutor({
    @Field() String? tutorId,
  });

  @GET(ApiContract.schedule)
  Future<ScheduleResponse> getSchedule({
    @Path() String? tutorId,
    @Path() int? startTimestamp,
    @Path() int? endTimestamp,
  });

  @POST(ApiContract.booking)
  Future<ScheduleResponseData> bookClass({
    @Field() List<String>? scheduleDetailIds,
    @Field() String? note,
  });

  @GET(ApiContract.tutorFeedback)
  Future<FeedbackResponse> getTutorFeedback({
    @Path() String? tutorId,
    @Path() int? page,
    @Path() int? perPage,
  });

  @GET(ApiContract.bookedSchedule)
  Future<BookingInfoResponse> getBookedSchedule({
    @Path() String from = '',
    @Path() int? page,
    @Path() int? perPage,
    @Path() String to = '',
  });

  @DELETE(ApiContract.deleteBookedSchedule)
  Future<ManageResponse> deleteBookedSchedule({
    @Field() String? scheduleDetailId,
    @Field() Map<String, dynamic>? cancelInfo,
  });

  @POST(ApiContract.feedbackTutor)
  Future<ManageResponse> feedBackTutor({
    @Field() String? userId,
    @Field() int rating = 5,
    @Field() String? content,
    @Field() String? bookingId,
  });

  @GET(ApiContract.course)
  Future<CourseResponse> getCourses({
    @Path() String filter = '',
  });

  @GET(ApiContract.category)
  Future<CategoryResponseData> getCategories();

  @GET(ApiContract.eBook)
  Future<CourseResponse> getEBooks({
    @Path() String filter = '',
  });

  @GET(ApiContract.interactiveEBook)
  Future<CourseResponse> getInteractiveEBooks({
    @Path() String filter = '',
  });
}
