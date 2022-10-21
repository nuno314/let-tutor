import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../base/base.dart';
import '../interactor/sign_up_interactor.dart';
import '../repository/sign_up_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends AppBlocBase<SignUpEvent, SignUpState> {
  late final _interactor = SignUpInteractorImpl(
    SignUpRepositoryImpl(),
  );
  
  SignUpBloc() : super(SignUpInitial(viewModel: const _ViewModel())) {
    on<SignUpEvent>(_onSignUpEvent);
  }

  Future<void> _onSignUpEvent(
    SignUpEvent event,
    Emitter<SignUpState> emit,
  ) async {}
}