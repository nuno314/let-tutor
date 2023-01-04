// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:let_tutor/data/models/payment.dart';
import 'package:let_tutor/data/models/teacher.dart';

import 'user.dart';

part 'schedule.g.dart';

@JsonSerializable()
class Schedule {
  String? id;
  String? scheduleId;
  int? startPeriodTimestamp;
  int? endPeriodTimestamp;
  DateTime? createdAt;
  DateTime? updatedAt;
  @JsonKey(name: 'bookingInfo')
  List<BookingInfo>? bookingInfos;
  Teacher? tutorInfo;
  bool? isBooked;

  Schedule({
    this.id,
    this.scheduleId,
    this.startPeriodTimestamp,
    this.endPeriodTimestamp,
    this.createdAt,
    this.updatedAt,
    this.bookingInfos,
    this.tutorInfo,
    this.isBooked,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleToJson(this);
}
