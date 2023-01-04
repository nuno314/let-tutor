// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Teacher _$TeacherFromJson(Map<String, dynamic> json) => Teacher(
      json['id'] as String?,
      json['userId'] as String?,
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
      json['interests'] as String?,
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
      (json['feedbacks'] as List<dynamic>?)
          ?.map((e) => Feedback.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TeacherToJson(Teacher instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
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
      'interests': instance.interests,
      'price': instance.price,
      'isOnline': instance.isOnline,
      'isfavoritetutor': instance.isFavoriteTutor,
      'feedbacks': instance.feedbacks,
    };

FavoriteTeacher _$FavoriteTeacherFromJson(Map<String, dynamic> json) =>
    FavoriteTeacher();

Map<String, dynamic> _$FavoriteTeacherToJson(FavoriteTeacher instance) =>
    <String, dynamic>{};

Feedback _$FeedbackFromJson(Map<String, dynamic> json) => Feedback(
      id: json['id'] as String?,
      bookingId: json['bookingId'] as String?,
      firstId: json['firstId'] as String?,
      secondId: json['secondId'] as String?,
      rating: json['rating'] as int?,
      content: json['content'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      firstInfo: json['firstInfo'] == null
          ? null
          : User.fromJson(json['firstInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FeedbackToJson(Feedback instance) => <String, dynamic>{
      'id': instance.id,
      'bookingId': instance.bookingId,
      'firstId': instance.firstId,
      'secondId': instance.secondId,
      'rating': instance.rating,
      'content': instance.content,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'firstInfo': instance.firstInfo,
    };
