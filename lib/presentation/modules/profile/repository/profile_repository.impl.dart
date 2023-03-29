part of 'profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final RestApiRepository _restApi = injector.get<AppApiService>().client;

  @override
  Future<User?> getUserInformation() {
    return _restApi.getUserInfomation({}).then((value) => value?.user);
  }
}
