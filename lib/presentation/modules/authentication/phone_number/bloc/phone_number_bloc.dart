import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../base/base.dart';

part 'phone_number_event.dart';
part 'phone_number_state.dart';

class PhoneNumberBloc extends AppBlocBase<PhoneNumberEvent, PhoneNumberState> {
  
  PhoneNumberBloc() : super(PhoneNumberInitial(viewModel: const _ViewModel())) {
    on<PhoneNumberEvent>(_onPhoneNumberEvent);
  }

  Future<void> _onPhoneNumberEvent(
    PhoneNumberEvent event,
    Emitter<PhoneNumberState> emit,
  ) async {}
}