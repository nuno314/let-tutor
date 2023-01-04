// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'teacher.g.dart';

@JsonSerializable()
class Teacher {
  final String? id;
  final String? userId;
  final String? name;
  final String? email;
  final String? avatar;
  final String? countryUrl;
  final String? country;
  final String? phone;
  final String? language;
  final String? birthday;
  final double? rating;
  final String? description;
  final List<String>? categories;
  final String? bio;
  final String? video;
  final String? education;
  final String? level;
  final String? experience;
  final String? profession;
  final String? targetStudent;
  final String? specialties;
  final String? interests;
  final int? price;
  final bool? isOnline;
  @JsonKey(name: 'isfavoritetutor')
  final String? isFavoriteTutor;
  final List<Feedback>? feedbacks;

  factory Teacher.fromJson(Map<String, dynamic> json) =>
      _$TeacherFromJson(json);

  Teacher(
    this.id,
    this.userId,
    this.name,
    this.email,
    this.avatar,
    this.countryUrl,
    this.country,
    this.phone,
    this.language,
    this.birthday,
    this.rating,
    this.description,
    this.interests,
    this.categories,
    this.bio,
    this.video,
    this.education,
    this.level,
    this.experience,
    this.profession,
    this.targetStudent,
    this.specialties,
    this.price,
    this.isOnline,
    this.isFavoriteTutor,
    this.feedbacks,
  );

  Map<String, dynamic> toJson() => _$TeacherToJson(this);

  bool get isFavorite => isFavoriteTutor == '1';
}

@JsonSerializable()
class FavoriteTeacher {}

@JsonSerializable()
class Feedback {
  String? id;
  String? bookingId;
  String? firstId;
  String? secondId;
  int? rating;
  String? content;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? firstInfo;
  Feedback({
    this.id,
    this.bookingId,
    this.firstId,
    this.secondId,
    this.rating,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.firstInfo,
  });
  factory Feedback.fromJson(Map<String, dynamic> json) =>
      _$FeedbackFromJson(json);
  Map<String, dynamic> toJson() => _$FeedbackToJson(this);
}
