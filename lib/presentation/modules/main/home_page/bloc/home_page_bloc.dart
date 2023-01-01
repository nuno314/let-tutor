import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
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
    add(GetDataEvent());
  }

  Pagination pagination = Pagination(limit: 5);

  Future<void> _onGetDataEvent(
    GetDataEvent event,
    Emitter<HomePageState> emit,
  ) async {
    pagination = Pagination(limit: 5);
    final res = await _restApi.getBookedClasses(
      from: DateTime.now().millisecondsSinceEpoch.toString(),
      page: '1',
      perPage: '1',
    );
    print('pre');
    print(pagination.offset);
    print(pagination.limit);
    print(pagination.total);
    final tutorList = await _restApi.getTutorList(
      page: pagination.firstPage.toString(),
      perPage: pagination.limit.toString(),
    );
    final length = tutorList.tutors?.tutors?.length ?? 0;
    pagination = Pagination(
      offset: pagination.total,
      total: pagination.total + length,
    );
    print(pagination.offset);
    print(pagination.limit);
    print(pagination.total);
    print(pagination.offset + pagination.limit - pagination.total);
    print(pagination.canNext);
    emit(
      state.copyWith(
        viewModel: state.viewModel.copyWith(
          tutors: tutorList.tutors?.tutors,
          upcomingLessons: res.data?.bookingInfos,
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
      page: pagination.currentPage.toString(),
      perPage: pagination.limit.toString(),
    );

    res.addAll(moreData.tutors?.tutors ?? []);

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
}
