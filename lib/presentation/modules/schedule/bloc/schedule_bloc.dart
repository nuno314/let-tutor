import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:let_tutor/data/data_source/remote/app_api_service.dart';
import 'package:let_tutor/data/models/document.dart';
import 'package:let_tutor/di/di.dart';

import '../../../../data/models/schedule.dart';
import '../../../../data/models/session.dart';
import '../../../base/base.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends AppBlocBase<ScheduleEvent, ScheduleState> {
  final _restApi = injector.get<AppApiService>().client;

  ScheduleBloc() : super(ScheduleInitial(viewModel: const _ViewModel())) {
    on<ScheduleEvent>(_onScheduleEvent);
  }

  Future<void> _onScheduleEvent(
    ScheduleEvent event,
    Emitter<ScheduleState> emit,
  ) async {}
}
