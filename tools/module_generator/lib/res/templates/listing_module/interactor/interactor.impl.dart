import '../../../../common/definations.dart';

const listingModuleInteractorImpl =
    '''part of '${moduleNameKey}_interactor.dart';

class ${classNameKey}InteractorImpl extends ${classNameKey}Interactor {
  final ${classNameKey}Repository _repository;

  ${classNameKey}InteractorImpl(this._repository);

  //TODO: Update to your model
  late ListingUseCase<Model, dynamic> _listingUsecase =
      ListingUseCase(
    (offset, limit, [param]) => _repository.getData(offset, limit),
  );

  @override
  Pagination get pagination => _listingUsecase.pagination;

  @override
  //TODO: Update to your model
  Future<List<Model>> getData() {
    return _listingUsecase.getData();
  }

  @override
  //TODO: Update to your model
  Future<List<Model>> loadMoreData() {
    return _listingUsecase.loadMoreData();
  }
}
''';
