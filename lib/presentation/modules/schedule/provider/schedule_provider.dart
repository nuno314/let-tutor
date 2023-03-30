import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/models/payment.dart';
import '../../../../domain/entities/pagination.entity.dart';
import '../repository/schedule_repository.dart';

part 'schedule_state.dart';

final scheduleProvider = StateNotifierProvider<ScheduleProvider, ScheduleState>(
    (ref) => ScheduleProvider(ref.read(scheduleRepositoryProvider)));

class ScheduleProvider extends StateNotifier<ScheduleState> {
  final ScheduleRepository repository;

  ScheduleProvider(this.repository)
      : super(ScheduleInitial(viewModel: const _ViewModel()));

  Pagination pagination = Pagination(limit: 20);

  Future<void> getSchedule() async {
    pagination = Pagination(limit: 20);
    final schedules = await repository.getBookedSchedule(
      page: pagination.firstPage,
      perPage: pagination.limit,
      from: DateTime.now(),
    );

    pagination = Pagination(
      offset: pagination.total,
      total: pagination.total + schedules.length,
    );

    state = state.copyWith<ScheduleInitial>(
      viewModel: state.viewModel.copyWith(
        schedules: schedules,
        canLoadMore: pagination.canNext,
      ),
    );
  }

  Future<void> loadMoreSchedule() async {
    final schedules = await repository.getBookedSchedule(
      page: pagination.currentPage,
      perPage: pagination.limit,
      from: DateTime.now(),
    );
    pagination = Pagination(
      offset: pagination.total,
      total: pagination.total + schedules.length,
    );
    state = state.copyWith<ScheduleInitial>(
      viewModel: state.viewModel.copyWith(
        schedules: [
          ...state.schedules,
          ...schedules,
        ],
        canLoadMore: pagination.canNext,
      ),
    );
  }

  Future<void> cancelBooking({
    String? scheduleId,
    int? reason,
    String? note,
  }) async {
    final res = await repository.deleteBookedSchedule(
      scheduleDetailId: scheduleId,
      cancelInfo: {
        'cancelReasonId': reason?.toString(),
        'note': note,
      },
    );
    if (res == true) {
      state = state.copyWith<CancelBookingState>();
    }
  }
}
