import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:let_tutor/data/data_source/remote/app_api_service.dart';
import 'package:let_tutor/data/models/course.dart';
import 'package:let_tutor/di/di.dart';
import 'package:let_tutor/domain/entities/pagination.entity.dart';

import '../../../../domain/entities/courses_filter.entity.dart';
import '../../../base/base.dart';

part 'courses_event.dart';
part 'courses_state.dart';

class CoursesBloc extends AppBlocBase<CoursesEvent, CoursesState> {
  final _restApi = injector.get<AppApiService>().client;

  CoursesBloc() : super(CoursesInitial(viewModel: const _ViewModel())) {
    on<GetCoursesEvent>(_onGetCoursesEvent);
    on<LoadMoreCoursesEvent>(_onLoadMoreCoursesEvent);

    on<GetEBooksEvent>(_onGetEBooksEvent);
    on<LoadMoreEBooksEvent>(_onLoadMoreEBooksEvent);

    on<GetInteractiveEBooksEvent>(_onGetInteractiveEBooksEvent);
    on<LoadMoreInteractiveEBooksEvent>(_onLoadMoreInteractiveEBooksEvent);

    on<InitialCoursesEvent>(_onInitialCoursesEvent);

    on<ApplyCoursesFilterEvent>(_onApplyCoursesFilterEvent);
    on<ApplyEBooksFilterEvent>(_onApplyEBooksFilterEvent);
    on<ApplyInteractiveEBooksFilterEvent>(_onApplyInteractiveEBooksFilterEvent);

    add(InitialCoursesEvent());
  }

  Future<void> _onInitialCoursesEvent(
    InitialCoursesEvent event,
    Emitter<CoursesState> emit,
  ) async {
    final categoryResponse = await _restApi.getCategories();
    print(categoryResponse.categories);
    emit(
      state.copyWith<CoursesFilterInitial>(
        viewModel: state.viewModel.copyWith(
          coursesFilter: state.coursesFilter.copyWith(
            categoriesFilter: categoryResponse.categories,
            pagination: Pagination(),
          ),
          eBooksFilter: state.eBooksFilter.copyWith(
            categoriesFilter: categoryResponse.categories,
            pagination: Pagination(),
          ),
          interactiveEBooksFilter: state.interactiveEBooksFilter.copyWith(
            categoriesFilter: categoryResponse.categories,
            pagination: Pagination(),
          ),
        ),
      ),
    );
  }

  Future<void> _onGetCoursesEvent(
    GetCoursesEvent event,
    Emitter<CoursesState> emit,
  ) async {
    final res = await _restApi.getCourses(
      filter: state.coursesFilter
          .copyWith(
            pagination: Pagination(
              limit: 10,
            ),
          )
          .filter,
    );

    final courses = res.courses ?? [];
    final newPagination = Pagination(
      offset: Pagination().total,
      total: Pagination().total + courses.length,
      limit: 10,
    );
    emit(
      state.copyWith<CoursesInitial>(
        viewModel: state.viewModel.copyWith(
          courses: courses,
          canLoadMoreCourses: newPagination.canNext,
          coursesFilter: state.coursesFilter.copyWith(
            pagination: newPagination,
          ),
        ),
      ),
    );
  }

  Future<void> _onLoadMoreCoursesEvent(
    LoadMoreCoursesEvent event,
    Emitter<CoursesState> emit,
  ) async {
    final res = await _restApi.getCourses(
      filter: state.coursesFilter.filter,
    );
    final courses = res.courses ?? [];
    final newPagination = Pagination(
      offset: state.coursesFilter.pagination!.total,
      total: state.coursesFilter.pagination!.total + courses.length,
      limit: 10,
    );
    emit(
      state.copyWith<CoursesInitial>(
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
      ),
    );
  }

  Future<void> _onGetEBooksEvent(
    GetEBooksEvent event,
    Emitter<CoursesState> emit,
  ) async {
    final res = await _restApi.getEBooks(
      filter: state.eBooksFilter
          .copyWith(
            pagination: Pagination(
              limit: 10,
            ),
          )
          .filter,
    );

    final ebooks = res.courses ?? [];
    final newPagination = Pagination(
      offset: Pagination().total,
      total: Pagination().total + ebooks.length,
      limit: 10,
    );
    emit(
      state.copyWith<CoursesInitial>(
        viewModel: state.viewModel.copyWith(
          eBooks: ebooks,
          canLoadMoreEBooks: newPagination.canNext,
          eBooksFilter: state.eBooksFilter.copyWith(
            pagination: newPagination,
          ),
        ),
      ),
    );
  }

  Future<void> _onLoadMoreEBooksEvent(
    LoadMoreEBooksEvent event,
    Emitter<CoursesState> emit,
  ) async {
    final res = await _restApi.getEBooks(
      filter: state.eBooksFilter.filter,
    );
    final ebooks = res.courses ?? [];
    final newPagination = Pagination(
      offset: state.eBooksFilter.pagination!.total,
      total: state.eBooksFilter.pagination!.total + ebooks.length,
      limit: 10,
    );
    emit(
      state.copyWith<CoursesInitial>(
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
      ),
    );
  }

  Future<void> _onGetInteractiveEBooksEvent(
    GetInteractiveEBooksEvent event,
    Emitter<CoursesState> emit,
  ) async {
    final res = await _restApi.getInteractiveEBooks(
      filter: state.interactiveEBooksFilter
          .copyWith(
            pagination: Pagination(
              limit: 10,
            ),
          )
          .filter,
    );

    final interactiveEbooks = res.courses ?? [];
    final newPagination = Pagination(
      offset: Pagination().total,
      total: Pagination().total + interactiveEbooks.length,
      limit: 10,
    );
    emit(
      state.copyWith<CoursesInitial>(
        viewModel: state.viewModel.copyWith(
          interactiveEBooks: interactiveEbooks,
          canLoadMoreInteractiveEBooks: newPagination.canNext,
          interactiveEBooksFilter: state.interactiveEBooksFilter.copyWith(
            pagination: newPagination,
          ),
        ),
      ),
    );
  }

  Future<void> _onLoadMoreInteractiveEBooksEvent(
    LoadMoreInteractiveEBooksEvent event,
    Emitter<CoursesState> emit,
  ) async {
    final res = await _restApi.getInteractiveEBooks(
      filter: state.interactiveEBooksFilter.filter,
    );
    final interactiveEbooks = res.courses ?? [];
    final newPagination = Pagination(
      offset: state.interactiveEBooksFilter.pagination!.total,
      total: state.interactiveEBooksFilter.pagination!.total +
          interactiveEbooks.length,
      limit: 10,
    );
    emit(
      state.copyWith<CoursesInitial>(
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
      ),
    );
  }

  Future<void> _onApplyCoursesFilterEvent(
    ApplyCoursesFilterEvent event,
    Emitter<CoursesState> emit,
  ) async {
    emit(
      state.copyWith<ApplyCoursesFilterState>(
        viewModel: state.viewModel.copyWith(
          coursesFilter: event.filter,
        ),
      ),
    );
  }

  Future<void> _onApplyEBooksFilterEvent(
    ApplyEBooksFilterEvent event,
    Emitter<CoursesState> emit,
  ) async {
    emit(state.copyWith<ApplyEBooksFilterState>(
      viewModel: state.viewModel.copyWith(
        eBooksFilter: event.filter,
      ),
    ));
  }

  Future<void> _onApplyInteractiveEBooksFilterEvent(
    ApplyInteractiveEBooksFilterEvent event,
    Emitter<CoursesState> emit,
  ) async {
    emit(state.copyWith<ApplyInteractiveEBooksFilterState>(
      viewModel: state.viewModel.copyWith(
        interactiveEBooksFilter: event.filter,
      ),
    ));
  }
}
