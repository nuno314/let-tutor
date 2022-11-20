import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/data/models/document.dart';

import '../../../base/base.dart';

part 'histories_event.dart';
part 'histories_state.dart';

class HistoriesBloc extends AppBlocBase<HistoriesEvent, HistoriesState> {
  HistoriesBloc() : super(HistoriesInitial(viewModel: const _ViewModel())) {
    on<GetDataEvent>(_onGetDataEvent);
    on<LoadMoreDataEvent>(_onLoadMoreDataEvent);
  }

  Future<void> _onGetDataEvent(
    GetDataEvent event,
    Emitter<HistoriesState> emit,
  ) async {
    // emit(
    //   state.copyWith<HistoriesInitial>(
    //     viewModel: state.viewModel.copyWith(
    //       // data: data,
    //       canLoadMore: _interactor.pagination.canNext,
    //     ),
    //   ),
    // );
  }

  Future<void> _onLoadMoreDataEvent(
    LoadMoreDataEvent event,
    Emitter<HistoriesState> emit,
  ) async {}
}
