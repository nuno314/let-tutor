part of 'dashboard_bloc.dart';


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

abstract class DashboardState {
  final _ViewModel viewModel;

  DashboardState(this.viewModel);

  T copyWith<T extends DashboardState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == DashboardState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }
}

class DashboardInitial extends DashboardState {
  DashboardInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  DashboardInitial: (viewModel) => DashboardInitial(
        viewModel: viewModel,
      ),
};