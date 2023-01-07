part of 'meeting_bloc.dart';

class _ViewModel {
  final BookingInfo? info;
  const _ViewModel({
    this.info,
  });

  _ViewModel copyWith({BookingInfo? info}) {
    return _ViewModel(
      info: info ?? this.info,
    );
  }
}

abstract class MeetingState {
  final _ViewModel viewModel;

  MeetingState(this.viewModel);

  T copyWith<T extends MeetingState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == MeetingState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }

  BookingInfo? get info => viewModel.info;
}

class MeetingInitial extends MeetingState {
  MeetingInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  MeetingInitial: (viewModel) => MeetingInitial(
        viewModel: viewModel,
      ),
};
