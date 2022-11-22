// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String? id;
  String? email;
  String? name;
  @JsonKey(name: 'avatar')
  String? avatar;
  String? country;
  @JsonKey(name: 'phone')
  String? phoneNumber;
  bool? isPhoneActivated;
  String? birthday;
  String? level;
  User({
    this.id,
    this.name,
    this.avatar,
    this.email,
    this.country,
    this.phoneNumber,
    this.isPhoneActivated,
    this.birthday,
    this.level,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
