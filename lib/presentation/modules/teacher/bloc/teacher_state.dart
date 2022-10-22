part of 'teacher_bloc.dart';

class _ViewModel {
  //TODO: Update to your model
  final List<Teacher> teachers;
  final bool canLoadMore;

  const _ViewModel({
    this.canLoadMore = false,
    this.teachers = const [],
  });

  _ViewModel copyWith({
    //TODO: Update to your model
    List<Teacher>? teachers,
    bool? canLoadMore,
  }) {
    return _ViewModel(
      teachers: teachers ?? this.teachers,
      canLoadMore: canLoadMore ?? this.canLoadMore,
    );
  }
}

abstract class TeacherState {
  final _ViewModel viewModel;

  TeacherState(this.viewModel);

  T copyWith<T extends TeacherState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == TeacherState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }
}

class TeacherInitial extends TeacherState {
  TeacherInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  TeacherInitial: (viewModel) => TeacherInitial(
        viewModel: viewModel,
      ),
};