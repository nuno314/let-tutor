import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:let_tutor/data/models/payment.dart';

import '../../../../../data/data_source/remote/app_api_service.dart';
import '../../../../../data/data_source/remote/rest_api_repository/rest_api_repository.dart';
import '../../../../../di/di.dart';

part 'schedule_repository.impl.dart';

final scheduleRepositoryProvider = Provider<ScheduleRepository>((ref) {
  return ScheduleRepositoryImpl();
});

abstract class ScheduleRepository {
  Future<List<BookingInfo>> getBookedSchedule({
    required int page,
    required int perPage,
    DateTime? from,
  });

  Future<bool> deleteBookedSchedule({
    String? scheduleDetailId,
    required Map<String, String?> cancelInfo,
  });
}
