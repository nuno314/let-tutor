import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:let_tutor/data/data_source/remote/app_api_service.dart';
import 'package:let_tutor/data/data_source/remote/rest_api_repository/rest_api_repository.dart';
import 'package:let_tutor/di/di.dart';

import '../../../../base/base.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc
    extends AppBlocBase<ResetPasswordEvent, ResetPasswordState> {
  final _apiService = injector.get<AppApiService>();

  ResetPasswordBloc()
      : super(ResetPasswordInitial(viewModel: const _ViewModel())) {
    on<ResetByEmailEvent>(_onResetByEmailEvent);
    on<ResetByPhoneNumberEvent>(_onResetByPhoneNumberEvent);
  }

  FutureOr<void> _onResetByEmailEvent(
    ResetByEmailEvent event,
    Emitter<ResetPasswordState> emit,
  ) async {
    final res = await _apiService.client.forgotPassword({'email': event.email});
    emit(
      ResponseState(
        viewModel: _ViewModel(message: res?.message),
      ),
    );
  }

  FutureOr<void> _onResetByPhoneNumberEvent(
    ResetByPhoneNumberEvent event,
    Emitter<ResetPasswordState> emit,
  ) async {
    final res = await _apiService.client.resendOTP(
      {
        'phone': event.phoneNumber,
      },
    );
    emit(
      ResponseState(
        viewModel: _ViewModel(message: res?.message),
      ),
    );
  }
}
