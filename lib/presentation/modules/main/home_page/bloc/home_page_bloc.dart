import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/common/constants.dart';
import 'package:let_tutor/data/data_source/remote/app_api_service.dart';
import 'package:let_tutor/di/di.dart';
import 'package:let_tutor/domain/entities/pagination.entity.dart';
import 'package:let_tutor/domain/entities/tutor_list_filter.entity.dart';

import '../../../../../data/models/payment.dart';
import '../../../../../data/models/teacher.dart';
import '../../../../base/base.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends AppBlocBase<HomePageEvent, HomePageState> {
  final _restApi = injector.get<AppApiService>().client;

  HomePageBloc() : super(HomePageInitial(viewModel: const _ViewModel())) {
    on<GetDataEvent>(_onGetDataEvent);
    on<LoadMoreDataEvent>(_onLoadMoreDataEvent);

    on<FilterChangedEvent>(_onFilterChangedEvent);
    on<SearchTutorEvent>(_onSearchTutorEvent);
    on<FavoriteTutorEvent>(_onFavoriteTutorEvent);
    add(GetDataEvent());
  }

  Pagination pagination = Pagination();

  Future<void> _onGetDataEvent(
    GetDataEvent event,
    Emitter<HomePageState> emit,
  ) async {
    pagination = Pagination();
    final res = await _restApi.getNextBookingSchedule(
      dateTime: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    final tutorList = await _restApi.getTutorList(
      page: pagination.firstPage,
      perPage: pagination.limit,
      filters: state.tutorFilter.where,
    );
    final length = tutorList.tutors?.length ?? 0;
    pagination = Pagination(
      offset: pagination.total,
      total: pagination.total + length,
    );
    emit(
      state.copyWith<HomePageInitial>(
        viewModel: state.viewModel.copyWith(
          tutors: tutorList.tutors,
          upcomingLessons: res.bookingInfos,
          canLoadMore: pagination.canNext,
        ),
      ),
    );
  }

  Future<void> _onLoadMoreDataEvent(
    LoadMoreDataEvent event,
    Emitter<HomePageState> emit,
  ) async {
    final res = <Teacher>[];

    final moreData = await _restApi.getTutorList(
        page: pagination.currentPage, perPage: pagination.limit);

    res.addAll(moreData.tutors ?? []);

    pagination = Pagination(
      offset: pagination.total,
      total: pagination.total + res.length,
    );
    emit(
      state.copyWith(
        viewModel: state.viewModel.copyWith(
          tutors: [
            ...state.viewModel.tutors,
            ...res,
          ],
          canLoadMore: pagination.canNext,
        ),
      ),
    );
  }

  FutureOr<void> _onFilterChangedEvent(
    FilterChangedEvent event,
    Emitter<HomePageState> emit,
  ) {
    emit(
      state.copyWith<FilterChangedState>(
        viewModel: state.viewModel.copyWith(
          tutorFilter: event.filter,
        ),
      ),
    );
  }

  FutureOr<void> _onSearchTutorEvent(
    SearchTutorEvent event,
    Emitter<HomePageState> emit,
  ) async {
    pagination = Pagination();
    final tutorList = await _restApi.getTutorList(
      page: pagination.firstPage,
      perPage: pagination.limit,
      filters: state.tutorFilter.where,
      search: event.value,
    );
    final length = tutorList.tutors?.length ?? 0;
    pagination = Pagination(
      offset: pagination.total,
      total: pagination.total + length,
    );
    emit(
      state.copyWith<HomePageInitial>(
        viewModel: state.viewModel.copyWith(
          tutors: tutorList.tutors,
          canLoadMore: pagination.canNext,
        ),
      ),
    );
  }

  FutureOr<void> _onFavoriteTutorEvent(
    FavoriteTutorEvent event,
    Emitter<HomePageState> emit,
  ) async {
    await _restApi.favoriteTutor(tutorId: event.id);
    add(GetDataEvent());
  }
}
