part of 'schedule_provider.dart';

class _ViewModel {
  final List<BookingInfo> schedules;
  final bool? canLoadMore;
  const _ViewModel({
    this.schedules = const [],
    this.canLoadMore,
  });

  _ViewModel copyWith({
    List<BookingInfo>? schedules,
    bool? canLoadMore,
  }) {
    return _ViewModel(
      schedules: schedules ?? this.schedules,
      canLoadMore: canLoadMore ?? this.canLoadMore,
    );
  }
}

abstract class ScheduleState {
  final _ViewModel viewModel;

  ScheduleState(this.viewModel);

  T copyWith<T extends ScheduleState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == ScheduleState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }

  List<BookingInfo> get schedules => viewModel.schedules;
  bool get canLoadMore => viewModel.canLoadMore ?? false;
}

class ScheduleInitial extends ScheduleState {
  ScheduleInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

class CancelBookingState extends ScheduleState {
  CancelBookingState({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  ScheduleInitial: (viewModel) => ScheduleInitial(
        viewModel: viewModel,
      ),
  CancelBookingState: (viewModel) => CancelBookingState(
        viewModel: viewModel,
      ),
};

