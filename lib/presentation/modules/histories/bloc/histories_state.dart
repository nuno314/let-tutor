part of 'histories_bloc.dart';

class _ViewModel {
  final List<BookingInfo> bookings;
  final bool? canLoadMore;
  const _ViewModel({
    this.bookings = const [],
    this.canLoadMore,
  });

  _ViewModel copyWith({
    List<Session>? sessions,
    List<BookingInfo>? bookings,
    bool? canLoadMore,
  }) {
    return _ViewModel(
      bookings: bookings ?? this.bookings,
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

  List<BookingInfo> get bookings => viewModel.bookings;
  bool get canLoadMore => viewModel.canLoadMore ?? false;
}

class HistoriesInitial extends HistoriesState {
  HistoriesInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

class FeedbackTutorState extends HistoriesState {
  FeedbackTutorState({
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
  FeedbackTutorState: (viewModel) => FeedbackTutorState(
        viewModel: viewModel,
      ),
};
