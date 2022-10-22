// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String? id;
  String? name;
  String? avatarUrl;
  String? email;
  String? country;
  String? phoneNumber;
  bool? phoneNumberValidate;
  String? dob;
  String? level;
  List<String>? wantToLearn;
  String? schedule;
  User({
    this.id,
    this.name,
    this.avatarUrl,
    this.email,
    this.country,
    this.phoneNumber,
    this.phoneNumberValidate,
    this.dob,
    this.level,
    this.wantToLearn,
    this.schedule,
  });

    factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
