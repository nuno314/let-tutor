part of 'schedule_bloc.dart';

abstract class ScheduleEvent {}

class GetScheduleEvent extends ScheduleEvent {}

class LoadMoreScheduleEvent extends ScheduleEvent {}

class CancelBookingEvent extends ScheduleEvent {
  final String id;
  final int reason;
  final String notes;

  CancelBookingEvent({
    required this.id,
    required this.reason,
    required this.notes,
  });
}
