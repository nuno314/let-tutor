// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String?,
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
      email: json['email'] as String?,
      country: json['country'] as String?,
      phoneNumber: json['phone'] as String?,
      isPhoneActivated: json['isPhoneActivated'] as bool?,
      birthday: json['birthday'] as String?,
      level: json['level'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'avatar': instance.avatar,
      'country': instance.country,
      'phone': instance.phoneNumber,
      'isPhoneActivated': instance.isPhoneActivated,
      'birthday': instance.birthday,
      'level': instance.level,
    };
