import 'package:json_annotation/json_annotation.dart';

part 'session.g.dart';

@JsonSerializable()
class Session {
  final String? name;
  final String? id;
  final int? page;
  final String? description;

  Session({
    this.name,
    this.id,
    this.page,
    this.description,
  });
  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  Map<String, dynamic> toJson() => _$SessionToJson(this);
}
