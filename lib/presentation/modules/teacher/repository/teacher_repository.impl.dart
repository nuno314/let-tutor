part of 'teacher_repository.dart';

class TeacherRepositoryImpl extends TeacherRepository {
  @override
  //TODO: Update to your model
  Future<List<Teacher>> getData(
    int offset,
    int limit,
  ) {
    return Future.value(<Teacher>[]);
  }
}