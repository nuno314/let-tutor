import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:let_tutor/data/models/payment.dart';
import 'package:let_tutor/data/models/teacher.dart';

import '../../../../../data/data_source/remote/app_api_service.dart';
import '../../../../../data/data_source/remote/rest_api_repository/rest_api_repository.dart';
import '../../../../../di/di.dart';

part 'home_page_repository.impl.dart';

final homePageRepositoryProvider = Provider<HomePageRepository>((ref) {
  return HomePageRepositoryImpl();
});

abstract class HomePageRepository {
  Future<List<BookingInfo>> getNextBookingSchedule(DateTime dateTime);

  Future<List<Teacher>> getTutorList({
    required int page,
    required int perPage,
    Map<String, dynamic>? filter,
    String? search,
  });
}
