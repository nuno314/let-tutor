import 'package:json_annotation/json_annotation.dart';

part 'statistic.g.dart';

@JsonSerializable()
class Statistic {
  int? total;
  String? time;
  Statistic({
    this.total,
    this.time,
  });

  factory Statistic.fromJson(Map<String, dynamic> json) =>
      _$StatisticFromJson(json);

  Map<String, dynamic> toJson() => _$StatisticToJson(this);
}
