part of 'home_page_repository.dart';

class HomePageRepositoryImpl implements HomePageRepository {
  final RestApiRepository _restApi = injector.get<AppApiService>().client;

  @override
  Future<List<BookingInfo>> getNextBookingSchedule(DateTime dateTime) {
    return _restApi
        .getNextBookingSchedule(
            dateTime: dateTime.millisecondsSinceEpoch.toString())
        .then((value) => value.bookingInfos ?? []);
  }

  @override
  Future<List<Teacher>> getTutorList({
    required int page,
    required int perPage,
    Map<String, dynamic>? filter,
    String? search,
  }) {
    return _restApi
        .getTutorList(
          page: page,
          perPage: perPage,
          filters: filter,
          search: search,
        )
        .then((value) => value.tutors ?? []);
  }
}
