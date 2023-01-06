part of 'courses_bloc.dart';

class _ViewModel {
  final CoursesFilter filter;
  final List<Course> courses;
  final List<Course> eBooks;
  final List<Course> interactiveEBooks;
  final bool canLoadMore;
  const _ViewModel({
    this.filter = const CoursesFilter(),
    this.courses = const [],
    this.eBooks = const [],
    this.interactiveEBooks = const [],
    this.canLoadMore = false,
  });

  _ViewModel copyWith({
    CoursesFilter? filter,
    List<Course>? courses,
    List<Course>? eBooks,
    List<Course>? interactiveEBooks,
    bool? canLoadMore,
  }) {
    return _ViewModel(
      filter: filter ?? this.filter,
      courses: courses ?? this.courses,
      eBooks: eBooks ?? this.eBooks,
      interactiveEBooks: interactiveEBooks ?? this.interactiveEBooks,
      canLoadMore: canLoadMore ?? this.canLoadMore,
    );
  }
}

abstract class CoursesState {
  final _ViewModel viewModel;

  CoursesState(this.viewModel);

  T copyWith<T extends CoursesState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == CoursesState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }

  CoursesFilter get filter => viewModel.filter;
  List<Course> get courses => viewModel.courses;
  List<Course> get eBooks => viewModel.eBooks;
  List<Course> get interactiveEBooks => viewModel.interactiveEBooks;

  bool get canLoadMore => viewModel.canLoadMore;
}

class CoursesInitial extends CoursesState {
  CoursesInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

class CoursesFilterInitial extends CoursesState {
  CoursesFilterInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  CoursesInitial: (viewModel) => CoursesInitial(
        viewModel: viewModel,
      ),
  CoursesFilterInitial: (viewModel) => CoursesFilterInitial(
        viewModel: viewModel,
      ),
};
