part of 'profile_provider.dart';

enum ProfileStatus { initial, save }

class ProfileState {
  final ProfileStatus status;
  final User? user;

  ProfileState({
    this.status = ProfileStatus.initial,
    this.user,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    User? user,
  }) =>
      ProfileState(
        status: status ?? this.status,
        user: user ?? this.user,
      );
}
