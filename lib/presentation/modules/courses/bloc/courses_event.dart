part of 'courses_bloc.dart';

abstract class CoursesEvent {}

class InitialCoursesEvent extends CoursesEvent {}

class GetCoursesEvent extends CoursesEvent {}

class LoadMoreCoursesEvent extends CoursesEvent {}

class GetEBooksEvent extends CoursesEvent {}

class LoadMoreEBooksEvent extends CoursesEvent {}

class GetInteractiveEBooksEvent extends CoursesEvent {}

class LoadMoreInteractiveEBooksEvent extends CoursesEvent {}
