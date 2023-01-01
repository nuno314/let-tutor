part of 'tutor_bloc.dart';

class _ViewModel {
  //TODO: Update to your model
  final List<Teacher> data;
  final bool canLoadMore;

  const _ViewModel({
    this.canLoadMore = false,
    this.data = const [],
  });

  _ViewModel copyWith({
    //TODO: Update to your model
    List<Teacher>? data,
    bool? canLoadMore,
  }) {
    return _ViewModel(
      data: data ?? this.data,
      canLoadMore: canLoadMore ?? this.canLoadMore,
    );
  }
}

abstract class TutorState {
  final _ViewModel viewModel;

  TutorState(this.viewModel);

  T copyWith<T extends TutorState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == TutorState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }
}

class TutorInitial extends TutorState {
  TutorInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  TutorInitial: (viewModel) => TutorInitial(
        viewModel: viewModel,
      ),
};