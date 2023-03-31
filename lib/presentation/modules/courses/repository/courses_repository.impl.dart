part of 'courses_repository.dart';

class CoursesRepositoryImpl implements CoursesRepository {
  final _restApi = injector.get<AppApiService>().client;

  @override
  Future<List<Category>> getCategories() {
    return _restApi.getCategories().then((value) => value.categories ?? []);
  }

  @override
  Future<List<Course>> getCourses(CoursesFilter filter) {
    return _restApi.getCourses(filter: filter.filter).then(
          (value) => value.courses ?? [],
        );
  }

  @override
  Future<List<Course>> getEBooks(CoursesFilter filter) {
    return _restApi.getEBooks(filter: filter.filter).then(
          (value) => value.courses ?? [],
        );
  }

  @override
  Future<List<Course>> getInteractiveEBooks(CoursesFilter filter) {
    return _restApi.getInteractiveEBooks(filter: filter.filter).then(
          (value) => value.courses ?? [],
        );
  }
}
