// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tutor_bloc.dart';

abstract class TutorEvent {}

class GetTutorInfoEvent extends TutorEvent {
  String id;
  GetTutorInfoEvent({
    required this.id,
  });
}

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

class BookScheduleEvent extends TutorEvent {
  final Schedule schedule;
  final String? note;

  BookScheduleEvent(
    this.schedule,
    this.note,
  );
}

class GetReviewsEvent extends TutorEvent {}

class FavoriteTeacherEvent extends TutorEvent {}
