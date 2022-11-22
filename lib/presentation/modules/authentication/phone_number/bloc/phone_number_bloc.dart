import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:let_tutor/common/services/auth_service.dart';
import 'package:let_tutor/di/di.dart';

import '../../../../base/base.dart';

part 'phone_number_event.dart';
part 'phone_number_state.dart';

class PhoneNumberBloc extends AppBlocBase<PhoneNumberEvent, PhoneNumberState> {
  final _authService = injector.get<AuthService>();

  PhoneNumberBloc() : super(PhoneNumberInitial(viewModel: const _ViewModel())) {
    on<SignInByPhoneNumberEvent>(_onPhoneNumberEvent);
  }

  Future<void> _onPhoneNumberEvent(
    SignInByPhoneNumberEvent event,
    Emitter<PhoneNumberState> emit,
  ) async {
    final res = await _authService.loginWithPhoneNumber(
      phoneNumber: event.phoneNumber,
      password: event.password,
    );

    if (res?.success == true) {
      emit(SignInSuccess());
    }
  }
}
