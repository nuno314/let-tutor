part of 'histories_repository.dart';

class HistoriesRepositoryImpl implements HistoriesRepository {
  final RestApiRepository _restApi = injector.get<AppApiService>().client;

  @override
  Future<bool> feedBackTutor(
      {required int rating, String? content, String? bookingId}) {
    return _restApi
        .feedBackTutor(
          userId: injector.get<AppApiService>().currentUser?.id,
          content: content,
          rating: rating,
          bookingId: bookingId,
        )
        .then((value) =>
            value.message?.toLowerCase().contains('success') == true);
  }

  @override
  Future<List<BookingInfo>> getBookedSchedule({
    required int page,
    required int perPage,
    DateTime? to,
  }) {
    return _restApi
        .getBookedSchedule(
          page: page,
          perPage: perPage,
          to: to?.toUtc().millisecondsSinceEpoch.toString() ?? '',
        )
        .then((value) => value.schedules ?? []);
  }
}
