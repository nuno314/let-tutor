import 'package:json_annotation/json_annotation.dart';
import 'package:let_tutor/data/models/user.dart';

import 'token.dart';

part 'login_response.g.dart';

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
