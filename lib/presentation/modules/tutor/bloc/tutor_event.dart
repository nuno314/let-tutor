part of 'tutor_bloc.dart';

abstract class TutorEvent {}

class GetDataEvent extends TutorEvent {}

class LoadMoreDataEvent extends TutorEvent {}

class GetScheduleByTutorIdEvent extends TutorEvent {
  final String id;

  GetScheduleByTutorIdEvent(
    this.id,
  );
}

class ApplyScheduleFilter extends TutorEvent {
  final ScheduleFilter filter;

  ApplyScheduleFilter(this.filter);
}
