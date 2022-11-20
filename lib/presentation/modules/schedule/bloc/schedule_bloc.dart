import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:let_tutor/data/models/document.dart';
import 'package:let_tutor/presentation/common_widget/date_picker/flutter_datetime_picker/src/date_format.dart';

import '../../../../data/models/session.dart';
import '../../../base/base.dart';
import '../interactor/schedule_interactor.dart';
import '../repository/schedule_repository.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends AppBlocBase<ScheduleEvent, ScheduleState> {
  late final _interactor = ScheduleInteractorImpl(
    ScheduleRepositoryImpl(),
  );

  ScheduleBloc() : super(ScheduleInitial(viewModel: const _ViewModel())) {
    on<ScheduleEvent>(_onScheduleEvent);
  }

  Future<void> _onScheduleEvent(
    ScheduleEvent event,
    Emitter<ScheduleState> emit,
  ) async {}
}
