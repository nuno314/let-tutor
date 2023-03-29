import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:let_tutor/data/data_source/remote/app_api_service.dart';
import 'package:let_tutor/data/models/payment.dart';
import 'package:let_tutor/di/di.dart';

import '../../../../data/models/session.dart';
import '../../../../domain/entities/pagination.entity.dart';
import '../../../base/base.dart';

part 'histories_event.dart';
part 'histories_state.dart';

class HistoriesBloc extends AppBlocBase<HistoriesEvent, HistoriesState> {
  final _restApi = injector.get<AppApiService>().client;

  HistoriesBloc() : super(HistoriesInitial(viewModel: const _ViewModel())) {
    on<GetHistoriesEvent>(_onGetHistoriesEvent);
    on<LoadMoreHistoriesEvent>(_onLoadMoreHistoriesEvent);

    on<RateBookingEvent>(_onRateBookingEvent);
  }

  Pagination pagination = Pagination();

  Future<void> _onGetHistoriesEvent(
    GetHistoriesEvent event,
    Emitter<HistoriesState> emit,
  ) async {
    pagination = Pagination();
    final res = await _restApi.getBookedSchedule(
      page: pagination.firstPage,
      perPage: pagination.limit,
      to: DateTime.now().toUtc().millisecondsSinceEpoch.toString(),
    );
    final bookings = res.schedules ?? [];
    pagination = Pagination(
      offset: pagination.total,
      total: pagination.total + bookings.length,
    );

    emit(
      state.copyWith<HistoriesInitial>(
        viewModel: state.viewModel.copyWith(
          bookings: bookings,
          canLoadMore: pagination.canNext,
        ),
      ),
    );
  }

  FutureOr<void> _onLoadMoreHistoriesEvent(
    LoadMoreHistoriesEvent event,
    Emitter<HistoriesState> emit,
  ) async {
    final res = await _restApi.getBookedSchedule(
      page: pagination.currentPage,
      perPage: pagination.limit,
      to: DateTime.now().toUtc().millisecondsSinceEpoch.toString(),
    );
    final bookings = res.schedules ?? [];
    pagination = Pagination(
      offset: pagination.total,
      total: pagination.total + bookings.length,
    );
    emit(
      state.copyWith<HistoriesInitial>(
        viewModel: state.viewModel.copyWith(
          bookings: [
            ...state.bookings,
            ...bookings,
          ],
          canLoadMore: pagination.canNext,
        ),
      ),
    );
  }

  FutureOr<void> _onRateBookingEvent(
    RateBookingEvent event,
    Emitter<HistoriesState> emit,
  ) async {
    final res = await _restApi.feedBackTutor(
      userId: injector.get<AppApiService>().currentUser?.id,
      content: event.content,
      rating: event.rating,
      bookingId: event.bookingId,
    );
    if (res.message?.toLowerCase().contains('success') == true) {
      emit(state.copyWith<FeedbackTutorState>());
    }
  }
}
