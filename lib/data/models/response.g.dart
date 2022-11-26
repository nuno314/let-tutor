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
    };

TransactionResponse _$TransactionResponseFromJson(Map<String, dynamic> json) =>
    TransactionResponse()..count = json['count'] as int?;

Map<String, dynamic> _$TransactionResponseToJson(
        TransactionResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
    };
