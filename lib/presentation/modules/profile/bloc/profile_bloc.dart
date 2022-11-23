import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:let_tutor/data/data_source/remote/app_api_service.dart';
import 'package:let_tutor/di/di.dart';

import '../../../../data/models/user.dart';
import '../../../base/base.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends AppBlocBase<ProfileEvent, ProfileState> {
  final _restApi = injector.get<AppApiService>();

  ProfileBloc() : super(ProfileInitial(viewModel: _ViewModel())) {
    on<GetProfileEvent>(_onProfileEvent);
    on<UpdateProfileEvent>(_onUpdateProfileEvent);
  }

  Future<void> _onProfileEvent(
    GetProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final res = await _restApi.client.getUserInfomation({});
    emit(
      state.copyWith(
        viewModel: state.viewModel.copyWith(
          user: res?.user,
        ),
      ),
    );
  }

  FutureOr<void> _onUpdateProfileEvent(
    UpdateProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final res = await _restApi.client.updateUserInfomation(
      event.user.toBody(),
    );
    if (res?.user != null) {
      emit(
        UpdateProfileSuccess(
          viewModel: _ViewModel(
            user: res!.user,
          ),
        ),
      );
    }
  }
}
