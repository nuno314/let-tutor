part of 'teacher_bloc.dart';

abstract class TeacherEvent {}

class GetDataEvent extends TeacherEvent {}

class LoadMoreDataEvent extends TeacherEvent {}