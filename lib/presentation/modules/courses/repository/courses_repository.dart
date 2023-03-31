import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:let_tutor/data/data_source/remote/app_api_service.dart';
import 'package:let_tutor/data/models/course.dart';
import 'package:let_tutor/di/di.dart';
import 'package:let_tutor/domain/entities/courses_filter.entity.dart';

part 'courses_repository.impl.dart';

final coursesRepositoryProvider = Provider<CoursesRepository>((ref) {
  return CoursesRepositoryImpl();
});

abstract class CoursesRepository {
  Future<List<Category>> getCategories();

  Future<List<Course>> getCourses(CoursesFilter filter);

  Future<List<Course>> getEBooks(CoursesFilter filter);

  Future<List<Course>> getInteractiveEBooks(CoursesFilter filter);
}
