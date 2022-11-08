import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/models/teacher.dart';
import '../../../../base/base.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends AppBlocBase<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial(viewModel: const _ViewModel())) {
    on<GetDataEvent>(_onGetDataEvent);
    on<LoadMoreDataEvent>(_onLoadMoreDataEvent);
  }

  Future<void> _onGetDataEvent(
    GetDataEvent event,
    Emitter<HomePageState> emit,
  ) async {
    // final HomePages = await _interactor.getData();
    // emit(
    //   state.copyWith<HomePageInitial>(
    //     viewModel: state.viewModel.copyWith(
    //       HomePages: HomePages,
    //       canLoadMore: _interactor.pagination.canNext,
    //     ),
    //   ),
    // );
  }

  Future<void> _onLoadMoreDataEvent(
    LoadMoreDataEvent event,
    Emitter<HomePageState> emit,
  ) async {}
}
