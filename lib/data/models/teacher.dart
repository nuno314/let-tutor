import 'package:json_annotation/json_annotation.dart';

part 'teacher.g.dart';

@JsonSerializable()
class Teacher {
  final String? id;
  final String? name;
  final String? avatarUrl;
  final String? countryUrl;
  final String? country;
  final double? rating;
  final String? description;
  final List<String>? categories;

  Teacher({
    this.name,
    this.id,
    this.avatarUrl,
    this.countryUrl,
    this.country,
    this.rating,
    this.description,
    this.categories = const [],
  });

  factory Teacher.fromJson(Map<String, dynamic> json) =>
      _$TeacherFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherToJson(this);
}
