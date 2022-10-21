import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../base/base.dart';
import '../interactor/reset_password_interactor.dart';
import '../repository/reset_password_repository.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends AppBlocBase<ResetPasswordEvent, ResetPasswordState> {
  late final _interactor = ResetPasswordInteractorImpl(
    ResetPasswordRepositoryImpl(),
  );
  
  ResetPasswordBloc() : super(ResetPasswordInitial(viewModel: const _ViewModel())) {
    on<ResetPasswordEvent>(_onResetPasswordEvent);
  }

  Future<void> _onResetPasswordEvent(
    ResetPasswordEvent event,
    Emitter<ResetPasswordState> emit,
  ) async {}
}