// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedule _$ScheduleFromJson(Map<String, dynamic> json) => Schedule(
      id: json['id'] as String?,
      startPeriodTimestamp: json['startPeriodTimestamp'] as int?,
      endPeriodTimestamp: json['endPeriodTimestamp'] as int?,
      tutorInfo: json['tutorInfo'] == null
          ? null
          : User.fromJson(json['tutorInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'id': instance.id,
      'startPeriodTimestamp': instance.startPeriodTimestamp,
      'endPeriodTimestamp': instance.endPeriodTimestamp,
      'tutorInfo': instance.tutorInfo,
    };
