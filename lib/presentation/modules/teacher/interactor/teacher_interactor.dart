import 'package:let_tutor/data/models/teacher.dart';

import '../../../../domain/entities/pagination.entity.dart';
import '../repository/teacher_repository.dart';

part 'teacher_interactor.impl.dart';

abstract class TeacherInteractor {
  Pagination get pagination;

  //TODO: Update to your model
  Future<List<Teacher>> getData();

  //TODO: Update to your model
  Future<List<Teacher>> loadMoreData();
}
