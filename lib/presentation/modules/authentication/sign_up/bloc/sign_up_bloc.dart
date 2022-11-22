import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:let_tutor/data/data_source/remote/app_api_service.dart';
import 'package:let_tutor/di/di.dart';

import '../../../../base/base.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends AppBlocBase<SignUpEvent, SignUpState> {
  final _apiService = injector.get<AppApiService>();
  SignUpBloc() : super(SignUpInitial(viewModel: const _ViewModel())) {
    on<SignUpByEmailEvent>(_onSignUpByEmailEvent);
  }

  Future<void> _onSignUpByEmailEvent(
    SignUpByEmailEvent event,
    Emitter<SignUpState> emit,
  ) async {
    final res = await _apiService.client.registerByEmail(
      {
        'email': event.email,
        'password': event.password,
        'source': null,
      },
    );
    if (res != null) {
      emit(RegisterAccountSuccess());
    }
  }
}
