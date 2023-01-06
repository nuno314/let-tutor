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

    add(InitialCoursesEvent());
  }

  Future<void> _onInitialCoursesEvent(
    InitialCoursesEvent event,
    Emitter<CoursesState> emit,
  ) async {
    final categoryResponse = await _restApi.getCategories();
    emit(
      state.copyWith<CoursesFilterInitial>(
        viewModel: state.viewModel.copyWith(
          filter: state.filter.copyWith(
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
      filter: state.filter.filter,
    );
    final previousPagination = Pagination();
    final courses = res.courses ?? [];
    emit(
      state.copyWith<CoursesInitial>(
        viewModel: state.viewModel.copyWith(
          courses: courses,
          canLoadMore: state.filter.pagination?.canNext,
          filter: state.filter.copyWith(
            pagination: Pagination(
              offset: previousPagination.total,
              total: previousPagination.total + courses.length,
            ),
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
      filter: state.filter.filter,
    );
    final previousPagination = state.filter.pagination!;
    final courses = res.courses ?? [];
    emit(
      state.copyWith<CoursesInitial>(
        viewModel: state.viewModel.copyWith(
          courses: courses,
          canLoadMore: state.filter.pagination?.canNext,
          filter: state.filter.copyWith(
            pagination: Pagination(
              offset: previousPagination.total,
              total: previousPagination.total + courses.length,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onGetEBooksEvent(
    GetEBooksEvent event,
    Emitter<CoursesState> emit,
  ) async {}

  Future<void> _onLoadMoreEBooksEvent(
    LoadMoreEBooksEvent event,
    Emitter<CoursesState> emit,
  ) async {}

  Future<void> _onGetInteractiveEBooksEvent(
    GetInteractiveEBooksEvent event,
    Emitter<CoursesState> emit,
  ) async {}

  Future<void> _onLoadMoreInteractiveEBooksEvent(
    LoadMoreInteractiveEBooksEvent event,
    Emitter<CoursesState> emit,
  ) async {}
}
