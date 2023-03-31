import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:let_tutor/presentation/modules/histories/repository/histories_repository.dart';

import '../../../../data/models/payment.dart';
import '../../../../data/models/session.dart';
import '../../../../domain/entities/pagination.entity.dart';

part 'histories_state.dart';

final historiesProvider =
    StateNotifierProvider<HistoriesProvider, HistoriesState>(
        (ref) => HistoriesProvider(ref.read(historiesRepositoryProvider)));

class HistoriesProvider extends StateNotifier<HistoriesState> {
  HistoriesRepository repository;
  HistoriesProvider(this.repository) : super(HistoriesInitial());

  Pagination pagination = Pagination();
  Future<void> getHistoriesEvent() async {
    pagination = Pagination();
    final bookings = await repository.getBookedSchedule(
      page: pagination.firstPage,
      perPage: pagination.limit,
      to: DateTime.now(),
    );

    pagination = Pagination(
      offset: pagination.total,
      total: pagination.total + bookings.length,
    );

    state = state.copyWith<HistoriesInitial>(
      viewModel: state.viewModel.copyWith(
        bookings: bookings,
        canLoadMore: pagination.canNext,
      ),
    );
  }

  Future<void> loadMoreHistoriesEvent() async {
    final bookings = await repository.getBookedSchedule(
      page: pagination.currentPage,
      perPage: pagination.limit,
      to: DateTime.now(),
    );
    pagination = Pagination(
      offset: pagination.total,
      total: pagination.total + bookings.length,
    );
    state = state.copyWith<HistoriesInitial>(
      viewModel: state.viewModel.copyWith(
        bookings: [
          ...state.bookings,
          ...bookings,
        ],
        canLoadMore: pagination.canNext,
      ),
    );
  }

  Future<bool> rateBookingEvent({
    required int rating,
    String? content,
    String? bookingId,
  }) async {
    return repository.feedBackTutor(
      content: content,
      rating: rating,
      bookingId: bookingId,
    );
  }
}
