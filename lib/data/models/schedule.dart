// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

part 'schedule.g.dart';

@JsonSerializable()
class Schedule {
  String? id;
  String? startPeriod;
  String? endPeriod;
  User? tutorInfo;
  
  Schedule({
    this.id,
    this.startPeriod,
    this.endPeriod,
    this.tutorInfo,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleToJson(this);
}
