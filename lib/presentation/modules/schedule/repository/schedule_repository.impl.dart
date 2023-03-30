part of 'schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final RestApiRepository _restApi = injector.get<AppApiService>().client;

  @override
  Future<List<BookingInfo>> getBookedSchedule({
    required int page,
    required int perPage,
    DateTime? from,
  }) {
    return _restApi
        .getBookedSchedule(
          page: page,
          perPage: perPage,
          from: from?.toUtc().millisecondsSinceEpoch.toString() ?? '',
        )
        .then((value) => value.schedules ?? []);
  }

  @override
  Future<bool> deleteBookedSchedule(
      {String? scheduleDetailId, required Map<String, String?> cancelInfo}) {
    return _restApi
        .deleteBookedSchedule(
            scheduleDetailId: scheduleDetailId, cancelInfo: cancelInfo)
        .then(
          (value) => value.message?.toLowerCase().contains('success') == true,
        );
  }
}
