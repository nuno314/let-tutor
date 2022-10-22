part of 'teacher_interactor.dart';

class TeacherInteractorImpl extends TeacherInteractor {
  final TeacherRepository _repository;

  TeacherInteractorImpl(this._repository);

  var _pagination = Pagination();

  @override
  Pagination get pagination => _pagination;

  @override
  Future<List<Teacher>> getData() {
    return _repository.getData(
      pagination.offset,
      pagination.limit,
    );
  }

  @override
  Future<List<Teacher>> loadMoreData() {
    return _repository.getData(
      pagination.offset,
      pagination.limit,
    );
  }
}
