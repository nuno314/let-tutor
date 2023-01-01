import 'package:json_annotation/json_annotation.dart';

part 'teacher.g.dart';

@JsonSerializable()
class Teacher {
  final String? id;
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
  final int? price;
  final bool? isOnline;

  factory Teacher.fromJson(Map<String, dynamic> json) =>
      _$TeacherFromJson(json);

  Teacher(
    this.id,
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
  );

  Map<String, dynamic> toJson() => _$TeacherToJson(this);
}
