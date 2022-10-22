import 'package:let_tutor/data/models/teacher.dart';

part 'teacher_repository.impl.dart';

abstract class TeacherRepository {
  Future<List<Teacher>> getData(
    int offset,
    int limit,
  );
}