import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';

import '../../../../../data/data_source/remote/app_api_service.dart';
import '../../../../../di/di.dart';
import '../../../../base/base.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends AppBlocBase<ChangePasswordEvent, ChangePasswordState> {
  final _apiSerivce = injector.get<AppApiService>();

  ChangePasswordBloc()
      : super(ChangePasswordInitial(viewModel: const _ViewModel())) {
    on<ChangePasswordEvent>(_onChangePasswordEvent);
    on<ChangePasswordEventImpl>(_onChangePasswordEventImpl);
  }

  Future<void> _onChangePasswordEvent(
    ChangePasswordEvent event,
    Emitter<ChangePasswordState> emit,
  ) async {}

  FutureOr<void> _onChangePasswordEventImpl(
    ChangePasswordEventImpl event,
    Emitter<ChangePasswordState> emit,
  ) async {
    final res = await _apiSerivce.client.changePassword(
      {
        'password': event.password,
        'newPassword': event.newPassword,
      },
    );
    if (res != null) {
      emit(ChangePasswordSuccess());
    }
  }
}
