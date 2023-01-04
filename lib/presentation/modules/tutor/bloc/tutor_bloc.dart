import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/data/data_source/remote/app_api_service.dart';
import 'package:let_tutor/data/models/schedule.dart';
import 'package:let_tutor/data/models/teacher.dart';
import 'package:let_tutor/di/di.dart';
import 'package:let_tutor/domain/entities/schedule_filter.entity.dart';
import 'package:let_tutor/presentation/common_widget/date_picker/flutter_datetime_picker/src/date_format.dart';

import '../../../../domain/entities/pagination.entity.dart';
import '../../../base/base.dart';

part 'tutor_event.dart';
part 'tutor_state.dart';

class TutorBloc extends AppBlocBase<TutorEvent, TutorState> {
  final _restApi = injector.get<AppApiService>().client;
  TutorBloc() : super(TutorInitial(viewModel: const _ViewModel())) {
    on<GetScheduleByTutorIdEvent>(_onGetScheduleByTutorIdEvent);
    on<LoadMoreDataEvent>(_onLoadMoreDataEvent);

    on<ApplyScheduleFilter>(_onApplyScheduleFilter);
  }

  Pagination pagination = Pagination();

  Future<void> _onGetDataEvent(
    GetDataEvent event,
    Emitter<TutorState> emit,
  ) async {}

  Future<void> _onLoadMoreDataEvent(
    LoadMoreDataEvent event,
    Emitter<TutorState> emit,
  ) async {}

  FutureOr<void> _onGetScheduleByTutorIdEvent(
    GetScheduleByTutorIdEvent event,
    Emitter<TutorState> emit,
  ) async {
    print(state.filter);
    final res = await _restApi.getSchedule(
      tutorId: event.id,
      startTimestamp: state.filter.startTimestamp,
      endTimestamp: state.filter.endTimestamp,
    );
    final schedules = res.schedules
        ?.map((e) => e.scheduleDetails ?? [])
        .expand((element) => element)
        .toList();
    emit(
      state.copyWith<TutorInitial>(
        viewModel: state.viewModel.copyWith(
          schedules: schedules,
        ),
      ),
    );
  }

  FutureOr<void> _onApplyScheduleFilter(
    ApplyScheduleFilter event,
    Emitter<TutorState> emit,
  ) {
    emit(state.copyWith<FilterChangedState>(
      viewModel: state.viewModel.copyWith(
        filter: event.filter,
      ),
    ));
  }
}
