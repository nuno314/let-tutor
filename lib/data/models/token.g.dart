// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Token _$TokenFromJson(Map<String, dynamic> json) => Token(
      accessToken: json['access'] == null
          ? null
          : AccessToken.fromJson(json['access'] as Map<String, dynamic>),
      refreshToken: json['refresh'] == null
          ? null
          : RefreshToken.fromJson(json['refresh'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'access': instance.accessToken,
      'refresh': instance.refreshToken,
    };

AccessToken _$AccessTokenFromJson(Map<String, dynamic> json) => AccessToken(
      token: json['token'] as String?,
      expires: json['expires'] == null
          ? null
          : DateTime.parse(json['expires'] as String),
    );

Map<String, dynamic> _$AccessTokenToJson(AccessToken instance) =>
    <String, dynamic>{
      'token': instance.token,
      'expires': instance.expires?.toIso8601String(),
    };

RefreshToken _$RefreshTokenFromJson(Map<String, dynamic> json) => RefreshToken(
      token: json['token'] as String?,
      expires: json['expires'] == null
          ? null
          : DateTime.parse(json['expires'] as String),
    );

Map<String, dynamic> _$RefreshTokenToJson(RefreshToken instance) =>
    <String, dynamic>{
      'token': instance.token,
      'expires': instance.expires?.toIso8601String(),
    };
