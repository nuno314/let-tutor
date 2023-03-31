import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/models/course.dart';
import '../../../../domain/entities/courses_filter.entity.dart';
import '../../../../domain/entities/pagination.entity.dart';
import '../repository/courses_repository.dart';

part 'courses_state.dart';

final coursesProvider = StateNotifierProvider<CoursesProvider,CoursesState>(
    (ref) => CoursesProvider(ref.read(coursesRepositoryProvider)));

class CoursesProvider extends StateNotifier<CoursesState> {
  final CoursesRepository repository;
  CoursesProvider(this.repository)
      : super(CoursesInitial(viewModel: const _ViewModel()));

  Future<void> initialCoursesEvent() async {
    final categories = await repository.getCategories();
    state = state.copyWith<CoursesFilterInitial>(
      viewModel: state.viewModel.copyWith(
        coursesFilter: state.coursesFilter.copyWith(
          categoriesFilter: categories,
          pagination: Pagination(),
        ),
        eBooksFilter: state.eBooksFilter.copyWith(
          categoriesFilter: categories,
          pagination: Pagination(),
        ),
        interactiveEBooksFilter: state.interactiveEBooksFilter.copyWith(
          categoriesFilter: categories,
          pagination: Pagination(),
        ),
      ),
    );
  }

  Future<void> getCoursesEvent() async {
    final courses = await repository.getCourses(state.coursesFilter.copyWith(
      pagination: Pagination(
        limit: 10,
      ),
    ));

    final newPagination = Pagination(
      offset: Pagination().total,
      total: Pagination().total + courses.length,
      limit: 10,
    );
    state = state.copyWith<CoursesInitial>(
      viewModel: state.viewModel.copyWith(
        courses: courses,
        canLoadMoreCourses: newPagination.canNext,
        coursesFilter: state.coursesFilter.copyWith(
          pagination: newPagination,
        ),
      ),
    );
  }

  Future<void> loadMoreCoursesEvent() async {
    final courses = await repository.getCourses(state.coursesFilter);
    final newPagination = Pagination(
      offset: state.coursesFilter.pagination!.total,
      total: state.coursesFilter.pagination!.total + courses.length,
      limit: 10,
    );
    state = state.copyWith<CoursesInitial>(
      viewModel: state.viewModel.copyWith(
        courses: [
          ...state.courses,
          ...courses,
        ],
        canLoadMoreCourses: newPagination.canNext,
        coursesFilter: state.coursesFilter.copyWith(
          pagination: newPagination,
        ),
      ),
    );
  }

  Future<void> getEBooksEvent() async {
    final ebooks = await repository.getEBooks(state.eBooksFilter.copyWith(
      pagination: Pagination(
        limit: 10,
      ),
    ));

    final newPagination = Pagination(
      offset: Pagination().total,
      total: Pagination().total + ebooks.length,
      limit: 10,
    );
    state = state.copyWith<CoursesInitial>(
      viewModel: state.viewModel.copyWith(
        eBooks: ebooks,
        canLoadMoreEBooks: newPagination.canNext,
        eBooksFilter: state.eBooksFilter.copyWith(
          pagination: newPagination,
        ),
      ),
    );
  }

  Future<void> loadMoreEBooksEvent() async {
    final ebooks = await repository.getEBooks(state.eBooksFilter);
    final newPagination = Pagination(
      offset: state.eBooksFilter.pagination!.total,
      total: state.eBooksFilter.pagination!.total + ebooks.length,
      limit: 10,
    );
    state = state.copyWith<CoursesInitial>(
      viewModel: state.viewModel.copyWith(
        eBooks: [
          ...state.eBooks,
          ...ebooks,
        ],
        canLoadMoreEBooks: newPagination.canNext,
        eBooksFilter: state.eBooksFilter.copyWith(
          pagination: newPagination,
        ),
      ),
    );
  }

  Future<void> getInteractiveEBooksEvent() async {
    final interactiveEbooks = await repository
        .getInteractiveEBooks(state.interactiveEBooksFilter.copyWith(
      pagination: Pagination(
        limit: 10,
      ),
    ));

    final newPagination = Pagination(
      offset: Pagination().total,
      total: Pagination().total + interactiveEbooks.length,
      limit: 10,
    );
    state = state.copyWith<CoursesInitial>(
      viewModel: state.viewModel.copyWith(
        interactiveEBooks: interactiveEbooks,
        canLoadMoreInteractiveEBooks: newPagination.canNext,
        interactiveEBooksFilter: state.interactiveEBooksFilter.copyWith(
          pagination: newPagination,
        ),
      ),
    );
  }

  Future<void> loadMoreInteractiveEBooksEvent() async {
    final interactiveEbooks = await repository.getInteractiveEBooks(
      state.interactiveEBooksFilter,
    );
    final newPagination = Pagination(
      offset: state.interactiveEBooksFilter.pagination!.total,
      total: state.interactiveEBooksFilter.pagination!.total +
          interactiveEbooks.length,
      limit: 10,
    );
    state = state.copyWith<CoursesInitial>(
      viewModel: state.viewModel.copyWith(
        interactiveEBooks: [
          ...state.interactiveEBooks,
          ...interactiveEbooks,
        ],
        canLoadMoreInteractiveEBooks: newPagination.canNext,
        interactiveEBooksFilter: state.interactiveEBooksFilter.copyWith(
          pagination: newPagination,
        ),
      ),
    );
  }

  Future<void> applyCoursesFilterEvent(CoursesFilter filter) async {
    state = state.copyWith<ApplyCoursesFilterState>(
      viewModel: state.viewModel.copyWith(
        coursesFilter: filter,
      ),
    );
  }

  Future<void> applyEBooksFilterEvent(CoursesFilter filter) async {
    state = state.copyWith<ApplyEBooksFilterState>(
        viewModel: state.viewModel.copyWith(
      eBooksFilter: filter,
    ));
  }

  Future<void> applyInteractiveEBooksFilterEvent(CoursesFilter filter) async {
    state = state.copyWith<ApplyInteractiveEBooksFilterState>(
        viewModel: state.viewModel.copyWith(
      interactiveEBooksFilter: filter,
    ));
  }
}
