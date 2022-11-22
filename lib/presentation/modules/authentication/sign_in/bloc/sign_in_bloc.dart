import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:let_tutor/common/services/auth_service.dart';
import 'package:let_tutor/di/di.dart';

import '../../../../base/base.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends AppBlocBase<SignInEvent, SignInState> {
  final _authService = injector.get<AuthService>();

  SignInBloc() : super(SignInInitial(viewModel: const _ViewModel())) {
    on<SignInByEmailEvent>(_onSignInByEmailEvent);
    on<SignInByFacebookEvent>(_onSignInByFacebookEvent);
    on<SignInByGoogleEvent>(_onSignInByGoogleEvent);
  }

  Future<void> _onSignInByEmailEvent(
    SignInByEmailEvent event,
    Emitter<SignInState> emit,
  ) async {
    final response = await _authService.loginWithEmail(
      email: event.email ?? '',
      password: event.password ?? '',
    );

    if (response?.success == true) {
      emit(LoginSuccessState());
    }
  }

  Future<void> _onSignInByFacebookEvent(
    SignInByFacebookEvent event,
    Emitter<SignInState> emit,
  ) async {
    final response =
        await _authService.loginWithFacebook(token: event.accessToken);

    if (response?.success == true) {
      emit(LoginSuccessState());
    } else {
      emit(LoginFailedState());
    }
  }

  Future<void> _onSignInByGoogleEvent(
    SignInByGoogleEvent event,
    Emitter<SignInState> emit,
  ) async {
    final response =
        await _authService.loginWithGoogle(token: event.accessToken);

    if (response?.success == true) {
      emit(LoginSuccessState());
    } else {
      emit(LoginFailedState());
    }
  }
}
