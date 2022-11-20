// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Document _$DocumentFromJson(Map<String, dynamic> json) => Document(
      id: json['id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      textContent: json['textContent'] as String?,
      page: json['page'] as int?,
    );

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'textContent': instance.textContent,
      'page': instance.page,
    };
