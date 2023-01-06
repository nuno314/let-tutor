import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';

@JsonSerializable()
class Course {
  String? id;
  String? name;
  String? description;
  String? imageUrl;
  String? level;
  String? reason;
  String? purpose;
  @JsonKey(name: 'default_price')
  int? defaultPrice;
  @JsonKey(name: 'course_price')
  int? coursePrice;
  bool? visible;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Topic>? topics;
  List<Category>? categories;
  Course({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.level,
    this.reason,
    this.purpose,
    this.defaultPrice,
    this.coursePrice,
    this.visible,
    this.createdAt,
    this.updatedAt,
    this.topics,
    this.categories,
  });

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);
}

@JsonSerializable()
class Topic {
  String? id;
  String? courseId;
  int? orderCourse;
  String? name;
  String? nameFile;
  String? fileUrl;
  String? description;
  String? videoUrl;
  DateTime? createdAt;
  DateTime? updatedAt;
  Topic({
    this.id,
    this.courseId,
    this.orderCourse,
    this.name,
    this.nameFile,
    this.fileUrl,
    this.description,
    this.videoUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);

  Map<String, dynamic> toJson() => _$TopicToJson(this);
}

@JsonSerializable()
class Category {
  String? id;
  String? title;
  String? description;
  String? key;
  String? displayOrder;
  DateTime? createdAt;
  DateTime? updatedAt;
  Category({
    this.id,
    this.title,
    this.description,
    this.key,
    this.displayOrder,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
