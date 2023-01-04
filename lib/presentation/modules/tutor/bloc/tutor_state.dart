part of 'tutor_bloc.dart';

class _ViewModel {
  final Teacher? tutor;
  final ScheduleFilter filter;
  final List<Schedule> schedules;

  const _ViewModel({
    this.tutor,
    this.filter = const ScheduleFilter(),
    this.schedules = const [],
  });

  _ViewModel copyWith({
    Teacher? tutor,
    ScheduleFilter? filter,
    List<Schedule>? schedules,
  }) {
    return _ViewModel(
      tutor: tutor ?? this.tutor,
      filter: filter ?? this.filter,
      schedules: schedules ?? this.schedules,
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

  ScheduleFilter get filter => viewModel.filter;
  Teacher? get tutor => viewModel.tutor;
  List<Schedule> get schedules => viewModel.schedules;
}

class TutorInitial extends TutorState {
  TutorInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

class FilterChangedState extends TutorState {
  FilterChangedState({
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
  FilterChangedState: (viewModel) => FilterChangedState(
        viewModel: viewModel,
      ),
};
