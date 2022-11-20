import 'package:json_annotation/json_annotation.dart';

part 'document.g.dart';

@JsonSerializable()
class Document {
  final String? id;
  final String? title;
  final String? description;
  final String? textContent;
  final int? page;

  Document({
    this.id,
    this.title,
    this.description,
    this.textContent,
    this.page,
  });
}
