part of 'histories_bloc.dart';

class _ViewModel {
  final List<Document> data;
  final bool canLoadMore;

  const _ViewModel({
    this.canLoadMore = false,
    this.data = const [],
  });

  _ViewModel copyWith({
    //
    List<Document>? data,
    bool? canLoadMore,
  }) {
    return _ViewModel(
      data: data ?? this.data,
      canLoadMore: canLoadMore ?? this.canLoadMore,
    );
  }
}

abstract class HistoriesState {
  final _ViewModel viewModel;

  HistoriesState(this.viewModel);

  T copyWith<T extends HistoriesState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == HistoriesState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }
}

class HistoriesInitial extends HistoriesState {
  HistoriesInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  HistoriesInitial: (viewModel) => HistoriesInitial(
        viewModel: viewModel,
      ),
};