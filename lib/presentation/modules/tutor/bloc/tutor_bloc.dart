import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/data/models/teacher.dart';

import '../../../base/base.dart';

part 'tutor_event.dart';
part 'tutor_state.dart';

class TutorBloc extends AppBlocBase<TutorEvent, TutorState> {
  TutorBloc() : super(TutorInitial(viewModel: const _ViewModel())) {
    on<GetDataEvent>(_onGetDataEvent);
    on<LoadMoreDataEvent>(_onLoadMoreDataEvent);
  }

  Future<void> _onGetDataEvent(
    GetDataEvent event,
    Emitter<TutorState> emit,
  ) async {}

  Future<void> _onLoadMoreDataEvent(
    LoadMoreDataEvent event,
    Emitter<TutorState> emit,
  ) async {}
}
