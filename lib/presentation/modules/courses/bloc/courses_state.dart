part of 'courses_bloc.dart';

class _ViewModel {
  final CoursesFilter coursesFilter;
  final List<Course> courses;
  final bool canLoadMoreCourses;

  final CoursesFilter eBooksFilter;
  final List<Course> eBooks;
  final bool canLoadMoreEBooks;

  final CoursesFilter interactiveEBooksFilter;
  final List<Course> interactiveEBooks;
  final bool canLoadMoreInteractiveEBooks;

  const _ViewModel({
    this.coursesFilter = const CoursesFilter(),
    this.eBooksFilter = const CoursesFilter(),
    this.interactiveEBooksFilter = const CoursesFilter(),
    this.courses = const [],
    this.eBooks = const [],
    this.interactiveEBooks = const [],
    this.canLoadMoreCourses = false,
    this.canLoadMoreEBooks = false,
    this.canLoadMoreInteractiveEBooks = false,
  });

  _ViewModel copyWith({
    CoursesFilter? coursesFilter,
    CoursesFilter? eBooksFilter,
    CoursesFilter? interactiveEBooksFilter,
    List<Course>? courses,
    List<Course>? eBooks,
    List<Course>? interactiveEBooks,
    bool? canLoadMoreCourses,
    bool? canLoadMoreEBooks,
    bool? canLoadMoreInteractiveEBooks,
  }) {
    return _ViewModel(
      coursesFilter: coursesFilter ?? this.coursesFilter,
      eBooksFilter: eBooksFilter ?? this.eBooksFilter,
      interactiveEBooksFilter:
          interactiveEBooksFilter ?? this.interactiveEBooksFilter,
      courses: courses ?? this.courses,
      eBooks: eBooks ?? this.eBooks,
      interactiveEBooks: interactiveEBooks ?? this.interactiveEBooks,
      canLoadMoreCourses: canLoadMoreCourses ?? this.canLoadMoreCourses,
      canLoadMoreEBooks: canLoadMoreEBooks ?? this.canLoadMoreEBooks,
      canLoadMoreInteractiveEBooks:
          canLoadMoreInteractiveEBooks ?? this.canLoadMoreInteractiveEBooks,
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

  CoursesFilter get coursesFilter => viewModel.coursesFilter;
  CoursesFilter get eBooksFilter => viewModel.eBooksFilter;
  CoursesFilter get interactiveEBooksFilter =>
      viewModel.interactiveEBooksFilter;

  List<Course> get courses => viewModel.courses;
  List<Course> get eBooks => viewModel.eBooks;
  List<Course> get interactiveEBooks => viewModel.interactiveEBooks;

  bool get canLoadMoreCourses => viewModel.canLoadMoreCourses;
  bool get canLoadMoreEBooks => viewModel.canLoadMoreEBooks;
  bool get canLoadMoreInteractiveEBooks =>
      viewModel.canLoadMoreInteractiveEBooks;
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
