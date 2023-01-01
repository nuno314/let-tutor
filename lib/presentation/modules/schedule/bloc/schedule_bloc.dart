import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:let_tutor/data/models/document.dart';

import '../../../../data/models/session.dart';
import '../../../base/base.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends AppBlocBase<ScheduleEvent, ScheduleState> {

  ScheduleBloc() : super(ScheduleInitial(viewModel: const _ViewModel())) {
    on<ScheduleEvent>(_onScheduleEvent);
  }

  Future<void> _onScheduleEvent(
    ScheduleEvent event,
    Emitter<ScheduleState> emit,
  ) async {}
}
