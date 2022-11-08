part of 'home_page_bloc.dart';

class _ViewModel {
  final List<Teacher> teachers;
  final bool canLoadMore;

  const _ViewModel({
    this.canLoadMore = false,
    this.teachers = const [],
  });

  _ViewModel copyWith({
    List<Teacher>? teachers,
    bool? canLoadMore,
  }) {
    return _ViewModel(
      teachers: teachers ?? this.teachers,
      canLoadMore: canLoadMore ?? this.canLoadMore,
    );
  }
}

abstract class HomePageState {
  final _ViewModel viewModel;

  HomePageState(this.viewModel);

  T copyWith<T extends HomePageState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == HomePageState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }
}

class HomePageInitial extends HomePageState {
  HomePageInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  HomePageInitial: (viewModel) => HomePageInitial(
        viewModel: viewModel,
      ),
};