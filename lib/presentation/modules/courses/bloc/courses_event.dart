part of 'courses_bloc.dart';

abstract class CoursesEvent {}

class InitialCoursesEvent extends CoursesEvent {}

class GetCoursesEvent extends CoursesEvent {}

class LoadMoreCoursesEvent extends CoursesEvent {}

class GetEBooksEvent extends CoursesEvent {}

class LoadMoreEBooksEvent extends CoursesEvent {}

class GetInteractiveEBooksEvent extends CoursesEvent {}

class LoadMoreInteractiveEBooksEvent extends CoursesEvent {}

class ApplyCoursesFilterEvent extends CoursesEvent {
  final CoursesFilter filter;

  ApplyCoursesFilterEvent(this.filter);
}

class ApplyEBooksFilterEvent extends CoursesEvent {
  final CoursesFilter filter;

  ApplyEBooksFilterEvent(this.filter);
}

class ApplyInteractiveEBooksFilterEvent extends CoursesEvent {
  final CoursesFilter filter;

  ApplyInteractiveEBooksFilterEvent(this.filter);
}
