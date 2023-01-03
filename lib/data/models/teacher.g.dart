// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Teacher _$TeacherFromJson(Map<String, dynamic> json) => Teacher(
      json['id'] as String?,
      json['name'] as String?,
      json['email'] as String?,
      json['avatar'] as String?,
      json['countryUrl'] as String?,
      json['country'] as String?,
      json['phone'] as String?,
      json['language'] as String?,
      json['birthday'] as String?,
      (json['rating'] as num?)?.toDouble(),
      json['description'] as String?,
      (json['categories'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['bio'] as String?,
      json['video'] as String?,
      json['education'] as String?,
      json['level'] as String?,
      json['experience'] as String?,
      json['profession'] as String?,
      json['targetStudent'] as String?,
      json['specialties'] as String?,
      json['price'] as int?,
      json['isOnline'] as bool?,
      json['isfavoritetutor'] as String?,
    );

Map<String, dynamic> _$TeacherToJson(Teacher instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'avatar': instance.avatar,
      'countryUrl': instance.countryUrl,
      'country': instance.country,
      'phone': instance.phone,
      'language': instance.language,
      'birthday': instance.birthday,
      'rating': instance.rating,
      'description': instance.description,
      'categories': instance.categories,
      'bio': instance.bio,
      'video': instance.video,
      'education': instance.education,
      'level': instance.level,
      'experience': instance.experience,
      'profession': instance.profession,
      'targetStudent': instance.targetStudent,
      'specialties': instance.specialties,
      'price': instance.price,
      'isOnline': instance.isOnline,
      'isfavoritetutor': instance.isFavoriteTutor,
    };
