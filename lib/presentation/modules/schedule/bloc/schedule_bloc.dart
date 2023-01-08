import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:let_tutor/data/data_source/remote/app_api_service.dart';
import 'package:let_tutor/data/models/payment.dart';
import 'package:let_tutor/di/di.dart';

import '../../../../data/models/session.dart';
import '../../../../domain/entities/pagination.entity.dart';
import '../../../base/base.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends AppBlocBase<ScheduleEvent, ScheduleState> {
  final _restApi = injector.get<AppApiService>().client;

  ScheduleBloc() : super(ScheduleInitial(viewModel: const _ViewModel())) {
    on<GetScheduleEvent>(_onGetScheduleEvent);
    on<LoadMoreScheduleEvent>(_onLoadMoreScheduleEvent);

    on<CancelBookingEvent>(_onCancelBookingEvent);
  }

  Pagination pagination = Pagination(limit: 20);

  Future<void> _onGetScheduleEvent(
    GetScheduleEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    pagination = Pagination(limit: 20);
    final res = await _restApi.getBookedSchedule(
      page: pagination.firstPage,
      perPage: pagination.limit,
      from: DateTime.now().toUtc().millisecondsSinceEpoch.toString(),
    );
    final schedules = res.schedules ?? [];
    pagination = Pagination(
      offset: pagination.total,
      total: pagination.total + schedules.length,
    );

    emit(
      state.copyWith<ScheduleInitial>(
        viewModel: state.viewModel.copyWith(
          schedules: schedules,
          canLoadMore: pagination.canNext,
        ),
      ),
    );
  }

  FutureOr<void> _onLoadMoreScheduleEvent(
    LoadMoreScheduleEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    final res = await _restApi.getBookedSchedule(
      page: pagination.currentPage,
      perPage: pagination.limit,
      from: DateTime.now().toUtc().millisecondsSinceEpoch.toString(),
    );
    final bookings = res.schedules ?? [];
    pagination = Pagination(
      offset: pagination.total,
      total: pagination.total + bookings.length,
    );
    emit(
      state.copyWith<ScheduleInitial>(
        viewModel: state.viewModel.copyWith(
          schedules: [
            ...state.schedules,
            ...bookings,
          ],
          canLoadMore: pagination.canNext,
        ),
      ),
    );
  }

  FutureOr<void> _onCancelBookingEvent(
    CancelBookingEvent event,
    Emitter<ScheduleState> emit,
  ) async {
    final res = await _restApi.deleteBookedSchedule(
      scheduleDetailId: event.id,
      cancelInfo: {
        'cancelReasonId': event.reason,
        'note': event.notes,
      },
    );
    if (res.message?.toLowerCase().contains('success') == true) {
      emit(state.copyWith<CancelBookingState>());
    }
  }
}
