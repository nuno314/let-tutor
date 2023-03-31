import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/data_source/remote/app_api_service.dart';
import '../../../../data/data_source/remote/rest_api_repository/rest_api_repository.dart';
import '../../../../data/models/payment.dart';
import '../../../../di/di.dart';

part 'histories_repository.impl.dart';

final historiesRepositoryProvider = Provider<HistoriesRepository>((ref) {
  return HistoriesRepositoryImpl();
});

abstract class HistoriesRepository {
  Future<List<BookingInfo>> getBookedSchedule({
    required int page,
    required int perPage,
    DateTime? to,
  });

  Future<bool> feedBackTutor({
    required int rating,
    String? content,
    String? bookingId,
  });
}
