import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable()
class Token {
  @JsonKey(name: 'access')
  final AccessToken? accessToken;
  @JsonKey(name: 'refresh')
  final RefreshToken? refreshToken;

  Token({
    this.accessToken,
    this.refreshToken,
  });

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);

  bool get isValid =>
      accessToken?.isValid == true && refreshToken?.isValid == true;
}

@JsonSerializable()
class AccessToken {
  @JsonKey(name: 'token')
  final String? token;
  @JsonKey(name: 'expires')
  final DateTime? expires;

  AccessToken({
    this.token,
    this.expires,
  });
  factory AccessToken.fromJson(Map<String, dynamic> json) =>
      _$AccessTokenFromJson(json);

  Map<String, dynamic> toJson() => _$AccessTokenToJson(this);

  bool get isValid => token != null && expires != null;

  factory AccessToken.fromMap(Map<String, dynamic> map) {
    return AccessToken(
      token: map['token'] != null ? map['token'] as String : null,
      expires: map['expires'] == null
          ? null
          : DateTime.parse(map['expires'] as String),
    );
  }

  factory AccessToken.fromString(String source) {
    print(json.decode(source) as Map<String, dynamic>);
    return AccessToken.fromMap(json.decode(source) as Map<String, dynamic>);
  }
}

@JsonSerializable()
class RefreshToken {
  @JsonKey(name: 'token')
  final String? token;
  @JsonKey(name: 'expires')
  final DateTime? expires;

  RefreshToken({
    this.token,
    this.expires,
  });
  factory RefreshToken.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenToJson(this);

  bool get isValid => token != null && expires != null;

  factory RefreshToken.fromMap(Map<String, dynamic> map) {
    return RefreshToken(
      token: map['token'] != null ? map['token'] as String : null,
      expires: map['expires'] == null
          ? null
          : DateTime.parse(map['expires'] as String),
    );
  }

  factory RefreshToken.fromString(String source) {
    print(json.decode(source) as Map<String, dynamic>);
    return RefreshToken.fromMap(json.decode(source) as Map<String, dynamic>);
  }
}
