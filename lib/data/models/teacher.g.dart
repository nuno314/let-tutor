// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Teacher _$TeacherFromJson(Map<String, dynamic> json) => Teacher(
      name: json['name'] as String?,
      id: json['id'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      countryUrl: json['countryUrl'] as String?,
      country: json['country'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      description: json['description'] as String?,
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$TeacherToJson(Teacher instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatarUrl': instance.avatarUrl,
      'countryUrl': instance.countryUrl,
      'country': instance.country,
      'rating': instance.rating,
      'description': instance.description,
      'categories': instance.categories,
    };
