import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:let_tutor/data/data_source/remote/app_api_service.dart';
import 'package:let_tutor/data/data_source/remote/rest_api_repository/rest_api_repository.dart';
import 'package:let_tutor/di/di.dart';

import '../../../../data/models/user.dart';

part 'profile_repository.impl.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImpl();
});

abstract class ProfileRepository {
  Future<User?> getUserInformation();
}
