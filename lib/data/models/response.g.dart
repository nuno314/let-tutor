// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      token: json['tokens'] == null
          ? null
          : Token.fromJson(json['tokens'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
      'tokens': instance.token,
    };

ResponseData _$ResponseDataFromJson(Map<String, dynamic> json) => ResponseData(
      message: json['message'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseDataToJson(ResponseData instance) =>
    <String, dynamic>{
      'message': instance.message,
      'user': instance.user,
    };

PaymentResponseData _$PaymentResponseDataFromJson(Map<String, dynamic> json) =>
    PaymentResponseData(
      data: json['data'] == null
          ? null
          : PaymentResponse.fromJson(json['data'] as Map<String, dynamic>),
    )
      ..message = json['message'] as String?
      ..user = json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>);

Map<String, dynamic> _$PaymentResponseDataToJson(
        PaymentResponseData instance) =>
    <String, dynamic>{
      'message': instance.message,
      'user': instance.user,
      'data': instance.data,
    };

PaymentResponse _$PaymentResponseFromJson(Map<String, dynamic> json) =>
    PaymentResponse(
      total: json['total'] as int?,
      income: json['income'] as int?,
      outcome: json['outcome'] as int?,
      count: json['count'] as int?,
      rows: (json['rows'] as List<dynamic>?)
          ?.map((e) => Payment.fromJson(e as Map<String, dynamic>))
          .toList(),
      statistics: (json['statistics'] as List<dynamic>?)
          ?.map((e) => Statistic.fromJson(e as Map<String, dynamic>))
          .toList(),
      referrals: (json['referrals'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      bookingInfos: (json['bookingInfos'] as List<dynamic>?)
          ?.map((e) => BookingInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaymentResponseToJson(PaymentResponse instance) =>
    <String, dynamic>{
      'total': instance.total,
      'income': instance.income,
      'outcome': instance.outcome,
      'count': instance.count,
      'rows': instance.rows,
      'statistics': instance.statistics,
      'referrals': instance.referrals,
      'bookingInfos': instance.bookingInfos,
    };

TransactionResponse _$TransactionResponseFromJson(Map<String, dynamic> json) =>
    TransactionResponse()..count = json['count'] as int?;

Map<String, dynamic> _$TransactionResponseToJson(
        TransactionResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
    };

ScheduleResponse _$ScheduleResponseFromJson(Map<String, dynamic> json) =>
    ScheduleResponse(
      schedules: (json['scheduleOfTutor'] as List<dynamic>?)
          ?.map((e) =>
              ScheduleResponseByTutor.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ScheduleResponseToJson(ScheduleResponse instance) =>
    <String, dynamic>{
      'scheduleOfTutor': instance.schedules,
    };

ScheduleResponseByTutor _$ScheduleResponseByTutorFromJson(
        Map<String, dynamic> json) =>
    ScheduleResponseByTutor(
      id: json['id'] as String?,
      tutorId: json['tutorId'] as String?,
      startTimestamp: json['startTimestamp'] as int?,
      endTimestamp: json['endTimestamp'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      isBooked: json['isBooked'] as bool?,
      scheduleDetails: (json['scheduleDetails'] as List<dynamic>?)
          ?.map((e) => Schedule.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ScheduleResponseByTutorToJson(
        ScheduleResponseByTutor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tutorId': instance.tutorId,
      'startTimestamp': instance.startTimestamp,
      'endTimestamp': instance.endTimestamp,
      'createdAt': instance.createdAt?.toIso8601String(),
      'isBooked': instance.isBooked,
      'scheduleDetails': instance.scheduleDetails,
    };

ScheduleResponseData _$ScheduleResponseDataFromJson(
        Map<String, dynamic> json) =>
    ScheduleResponseData(
      bookingInfos: (json['data'] as List<dynamic>?)
          ?.map((e) => BookingInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..message = json['message'] as String?
      ..user = json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>);

Map<String, dynamic> _$ScheduleResponseDataToJson(
        ScheduleResponseData instance) =>
    <String, dynamic>{
      'message': instance.message,
      'user': instance.user,
      'data': instance.bookingInfos,
    };

TutorResponseData _$TutorResponseDataFromJson(Map<String, dynamic> json) =>
    TutorResponseData(
      tutors: json['tutors'] == null
          ? null
          : TutorResponse.fromJson(json['tutors'] as Map<String, dynamic>),
    )..favoriteTutors = (json['favoriteTutor'] as List<dynamic>?)
        ?.map((e) => Teacher.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$TutorResponseDataToJson(TutorResponseData instance) =>
    <String, dynamic>{
      'tutors': instance.tutors,
      'favoriteTutor': instance.favoriteTutors,
    };

TutorResponse _$TutorResponseFromJson(Map<String, dynamic> json) =>
    TutorResponse(
      count: json['count'] as int?,
      tutors: (json['rows'] as List<dynamic>?)
          ?.map((e) => Teacher.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TutorResponseToJson(TutorResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'rows': instance.tutors,
    };

ManageResponse _$ManageResponseFromJson(Map<String, dynamic> json) =>
    ManageResponse(
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ManageResponseToJson(ManageResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

FeedbackResponse _$FeedbackResponseFromJson(Map<String, dynamic> json) =>
    FeedbackResponse(
      data: json['data'] == null
          ? null
          : FeedbackResponseData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FeedbackResponseToJson(FeedbackResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

FeedbackResponseData _$FeedbackResponseDataFromJson(
        Map<String, dynamic> json) =>
    FeedbackResponseData(
      count: json['count'] as int?,
      feedbacks: (json['rows'] as List<dynamic>?)
          ?.map((e) => Feedback.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FeedbackResponseDataToJson(
        FeedbackResponseData instance) =>
    <String, dynamic>{
      'count': instance.count,
      'rows': instance.feedbacks,
    };

BookingInfoResponse _$BookingInfoResponseFromJson(Map<String, dynamic> json) =>
    BookingInfoResponse(
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : BookingInfoResponseData.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookingInfoResponseToJson(
        BookingInfoResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };

BookingInfoResponseData _$BookingInfoResponseDataFromJson(
        Map<String, dynamic> json) =>
    BookingInfoResponseData(
      count: json['count'] as int?,
      schedules: (json['rows'] as List<dynamic>?)
          ?.map((e) => BookingInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookingInfoResponseDataToJson(
        BookingInfoResponseData instance) =>
    <String, dynamic>{
      'count': instance.count,
      'rows': instance.schedules,
    };
