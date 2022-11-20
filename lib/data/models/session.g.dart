// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
      name: json['name'] as String?,
      id: json['id'] as String?,
      page: json['page'] as int?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'page': instance.page,
      'description': instance.description,
    };
