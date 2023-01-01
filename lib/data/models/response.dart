// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:let_tutor/common/utils.dart';
import 'package:let_tutor/data/models/payment.dart';
import 'package:let_tutor/data/models/statistic.dart';
import 'package:let_tutor/data/models/teacher.dart';
import 'package:let_tutor/data/models/user.dart';

import 'token.dart';

part 'response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: 'user')
  final User? user;
  @JsonKey(name: 'tokens')
  final Token? token;

  LoginResponse({
    this.token,
    this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  bool get success => user != null && token != null;

  String? get accessToken => token?.accessToken?.token;

  String? get refreshToken => token?.refreshToken?.token;
}

@JsonSerializable()
class ResponseData {
  String? message;
  @JsonKey(name: 'user')
  User? user;

  ResponseData({
    this.message,
    this.user,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) =>
      _$ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseDataToJson(this);
}

@JsonSerializable()
class PaymentResponseData extends ResponseData {
  PaymentResponse? data;
  PaymentResponseData({
    this.data,
  });
  factory PaymentResponseData.fromJson(Map<String, dynamic> json) =>
      _$PaymentResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentResponseDataToJson(this);
}

@JsonSerializable()
class PaymentResponse {
  int? total;
  int? income;
  int? outcome;
  int? count;
  List<Payment>? rows;
  List<Statistic>? statistics;
  List<User>? referrals;
  List<BookingInfo>? bookingInfos;
  PaymentResponse({
    this.total,
    this.income,
    this.outcome,
    this.count,
    this.rows,
    this.statistics,
    this.referrals,
    this.bookingInfos,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentResponseToJson(this);

  String? get firstTime {
    for (final Statistic statistic in statistics ?? []) {
      if (statistic.time.isNotNullOrEmpty) {
        return statistic.time;
      }
    }
    return null;
  }
}

@JsonSerializable()
class TransactionResponse {
  int? count;
}

@JsonSerializable()
class ScheduleResponseData extends ResponseData {
  ScheduleResponse? data;
  ScheduleResponseData({
    this.data,
  });
  factory ScheduleResponseData.fromJson(Map<String, dynamic> json) =>
      _$ScheduleResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleResponseDataToJson(this);
}

@JsonSerializable()
class ScheduleResponse {
  int? count;
  @JsonKey(name: 'rows')
  List<BookingInfo>? bookingInfos;
  ScheduleResponse({
    this.count,
    this.bookingInfos = const [],
  });

  factory ScheduleResponse.fromJson(Map<String, dynamic> json) =>
      _$ScheduleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleResponseToJson(this);
}

@JsonSerializable()
class TutorResponseData {
  @JsonKey(name: 'tutors')
  TutorResponse? tutors;
  TutorResponseData({
    this.tutors,
  });
  factory TutorResponseData.fromJson(Map<String, dynamic> json) =>
      _$TutorResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$TutorResponseDataToJson(this);
}

@JsonSerializable()
class TutorResponse {
  int? count;
  @JsonKey(name: 'rows')
  List<Teacher>? tutors;
  TutorResponse({
    this.count,
    this.tutors,
  });

  factory TutorResponse.fromJson(Map<String, dynamic> json) =>
      _$TutorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TutorResponseToJson(this);
}
