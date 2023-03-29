import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:let_tutor/presentation/modules/profile/repository/profile_repository.dart';

import '../../../../data/models/user.dart';

part 'profile_state.dart';

final profileProvider =
    StateNotifierProvider<ProfileProvider, ProfileState>((ref) {
  return ProfileProvider(ref.read(profileRepositoryProvider))
    ..getUserInformation();
});

class ProfileProvider extends StateNotifier<ProfileState> {
  final ProfileRepository repository;
  ProfileProvider(this.repository) : super(ProfileState());

  Future<void> getUserInformation() async {
    final res = await repository.getUserInformation();
    state = state.copyWith(user: res);
  }
}
