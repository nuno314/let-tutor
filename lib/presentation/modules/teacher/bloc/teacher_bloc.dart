import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/data/models/teacher.dart';

import '../../../base/base.dart';
import '../interactor/teacher_interactor.dart';
import '../repository/teacher_repository.dart';

part 'teacher_event.dart';
part 'teacher_state.dart';

class TeacherBloc extends AppBlocBase<TeacherEvent, TeacherState> {
  late final _interactor = TeacherInteractorImpl(
    TeacherRepositoryImpl(),
  );
  
  TeacherBloc() : super(TeacherInitial(viewModel: const _ViewModel())) {
    on<GetDataEvent>(_onGetDataEvent);
    on<LoadMoreDataEvent>(_onLoadMoreDataEvent);
  }

  Future<void> _onGetDataEvent(
    GetDataEvent event,
    Emitter<TeacherState> emit,
  ) async {
    // final teachers = await _interactor.getData();
    // emit(
    //   state.copyWith<TeacherInitial>(
    //     viewModel: state.viewModel.copyWith(
    //       teachers: teachers,
    //       canLoadMore: _interactor.pagination.canNext,
    //     ),
    //   ),
    // );
  }

  Future<void> _onLoadMoreDataEvent(
    LoadMoreDataEvent event,
    Emitter<TeacherState> emit,
  ) async {
    final moreData = await _interactor.loadMoreData();
    emit(
      state.copyWith<TeacherInitial>(
        viewModel: state.viewModel.copyWith(
          teachers: [...state.viewModel.teachers, ...moreData],
          canLoadMore: _interactor.pagination.canNext,
        ),
      ),
    );
  }
}
