import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/teacher.dart';
import '../../../base/base.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends AppBlocBase<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial(viewModel: const _ViewModel())) {
    on<GetDataEvent>(_onGetDataEvent);
    on<LoadMoreDataEvent>(_onLoadMoreDataEvent);
  }

  Future<void> _onGetDataEvent(
    GetDataEvent event,
    Emitter<DashboardState> emit,
  ) async {
    // final Dashboards = await _interactor.getData();
    // emit(
    //   state.copyWith<DashboardInitial>(
    //     viewModel: state.viewModel.copyWith(
    //       Dashboards: Dashboards,
    //       canLoadMore: _interactor.pagination.canNext,
    //     ),
    //   ),
    // );
  }

  Future<void> _onLoadMoreDataEvent(
    LoadMoreDataEvent event,
    Emitter<DashboardState> emit,
  ) async {}
}
