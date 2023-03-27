import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/data/data_source/remote/app_api_service.dart';
import 'package:let_tutor/data/data_source/remote/rest_api_repository/rest_api_repository.dart';
import 'package:let_tutor/data/models/schedule.dart';
import 'package:let_tutor/data/models/teacher.dart';
import 'package:let_tutor/di/di.dart';
import 'package:let_tutor/domain/entities/date_range.entity.dart';
import 'package:let_tutor/domain/entities/schedule_filter.entity.dart';

import '../../../../domain/entities/pagination.entity.dart';
import '../../../base/base.dart';

part 'tutor_event.dart';
part 'tutor_state.dart';

class TutorBloc extends AppBlocBase<TutorEvent, TutorState> {
  var _restApi = injector.get<AppApiService>().client;
  TutorBloc(Teacher? tutor, {RestApiRepository? restApi})
      : super(TutorInitial(
          viewModel: _ViewModel(
            tutor: tutor,
            filter: ScheduleFilter(
              dateRange: DateRange(
                from: DateTime.now(),
                to: DateTime.now().add(
                  const Duration(
                    days: 7,
                  ),
                ),
              ),
            ),
          ),
        )) {
    if (restApi != null) _restApi = restApi;
    on<GetTutorInfoEvent>(_onGetTutorInfoEvent);
    on<GetScheduleByTutorIdEvent>(_onGetScheduleByTutorIdEvent);
    on<ApplyScheduleFilter>(_onApplyScheduleFilter);
    on<BookScheduleEvent>(_onBookScheduleEvent);
    on<GetReviewsEvent>(_onGetReviewEvent);
    on<FavoriteTeacherEvent>(_onFavoriteTeacherEvent);
  }
  Pagination pagination = Pagination();

  FutureOr<void> _onGetScheduleByTutorIdEvent(
    GetScheduleByTutorIdEvent event,
    Emitter<TutorState> emit,
  ) async {
    final res = await _restApi.getSchedule(
      tutorId: event.id,
      startTimestamp: state.filter.startTimestamp,
      endTimestamp: state.filter.endTimestamp,
    );
    final schedules = res.schedules
            ?.map((e) => e.scheduleDetails ?? [])
            .expand((element) => element)
            .toList() ??
        [];
    schedules.sort(((a, b) => DateTime.fromMillisecondsSinceEpoch(
          a.startPeriodTimestamp ?? 0,
        ).compareTo(DateTime.fromMillisecondsSinceEpoch(
          b.startPeriodTimestamp ?? 0,
        ))));
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

  FutureOr<void> _onBookScheduleEvent(
    BookScheduleEvent event,
    Emitter<TutorState> emit,
  ) async {
    final res = await _restApi.bookClass(
      scheduleDetailIds: [
        event.schedule.id!,
      ],
      note: event.note,
    );
    if (res.message?.toLowerCase().contains('success') == true) {
      emit(
        state.copyWith<BookScheduleSuccessfulState>(
          viewModel: state.viewModel.copyWith(),
        ),
      );
    }
  }

  FutureOr<void> _onGetReviewEvent(
    GetReviewsEvent event,
    Emitter<TutorState> emit,
  ) async {
    pagination = Pagination();
    final res = await _restApi.getTutorFeedback(
      tutorId: state.tutor?.userId,
      page: pagination.firstPage,
      perPage: pagination.limit,
    );
    final length = res.feedbacks.length;
    pagination = Pagination(
      offset: pagination.total,
      total: pagination.total + length,
    );
    emit(
      state.copyWith<FeedbackState>(
        viewModel: state.viewModel.copyWith(
          feedbacks: res.feedbacks,
        ),
      ),
    );
  }

  Future<void> _onFavoriteTeacherEvent(
    FavoriteTeacherEvent event,
    Emitter<TutorState> emit,
  ) async {}

  Future<void> _onGetTutorInfoEvent(
    GetTutorInfoEvent event,
    Emitter<TutorState> emit,
  ) async {
    print(event.id);
    final res = await _restApi.getTutorById(tutorId: event.id);
    print(res);
    emit(
      state.copyWith<GetTutorState>(
        viewModel: state.viewModel.copyWith(tutor: res),
      ),
    );
  }
}
