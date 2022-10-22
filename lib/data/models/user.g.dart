// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String?,
      name: json['name'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      email: json['email'] as String?,
      country: json['country'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      phoneNumberValidate: json['phoneNumberValidate'] as bool?,
      dob: json['dob'] as String?,
      level: json['level'] as String?,
      wantToLearn: (json['wantToLearn'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      schedule: json['schedule'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
      'email': instance.email,
      'country': instance.country,
      'phoneNumber': instance.phoneNumber,
      'phoneNumberValidate': instance.phoneNumberValidate,
      'dob': instance.dob,
      'level': instance.level,
      'wantToLearn': instance.wantToLearn,
      'schedule': instance.schedule,
    };
