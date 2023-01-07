import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:let_tutor/data/models/payment.dart';

import '../../../base/base.dart';

part 'meeting_event.dart';
part 'meeting_state.dart';

class MeetingBloc extends AppBlocBase<MeetingEvent, MeetingState> {
  MeetingBloc(BookingInfo info)
      : super(
          MeetingInitial(
            viewModel: _ViewModel(
              info: info,
            ),
          ),
        ) {
    on<InitialMeetingEvent>(_onInitialMeetingEvent);

    add(InitialMeetingEvent());
  }

  Future<void> _onInitialMeetingEvent(
    InitialMeetingEvent event,
    Emitter<MeetingState> emit,
  ) async {
    emit(state.copyWith<MeetingInitial>());
  }
}
