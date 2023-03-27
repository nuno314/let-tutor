import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:let_tutor/data/data_source/remote/app_api_service.dart';
import 'package:let_tutor/di/di.dart';

import '../../../base/base.dart';

part 'register_tutor_event.dart';
part 'register_tutor_state.dart';

class RegisterTutorBloc
    extends AppBlocBase<RegisterTutorEvent, RegisterTutorState> {
  final _restApi = injector.get<AppApiService>().client;
  final me = injector.get<AppApiService>().currentUser!;
  RegisterTutorBloc()
      : super(RegisterTutorInitial(viewModel: const _ViewModel())) {
    on<RegisterTutorSuccessEvent>(_onRegisterTutorSuccessEvent);
  }

  Future<void> _onRegisterTutorSuccessEvent(
    RegisterTutorSuccessEvent event,
    Emitter<RegisterTutorState> emit,
  ) async {
    await _restApi.registerTutor(
      name: me.name,
      country: me.country,
      birthday: event.birthday,
      interests: event.interests,
      education: event.education,
      experience: event.experience,
      profession: event.profression,
      languages: event.languages,
      bio: event.bio,
      targetStudent: event.targetStudent,
      specialties: event.specialties,
      avatar: event.avatar,
    );
  }
}
