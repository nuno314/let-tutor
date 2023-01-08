part of 'tutor_bloc.dart';

class _ViewModel {
  final Teacher? tutor;
  final ScheduleFilter filter;
  final List<Schedule> schedules;
  final List<Feedback> feedbacks;

  const _ViewModel({
    this.tutor,
    this.filter = const ScheduleFilter(),
    this.schedules = const [],
    this.feedbacks = const [],
  });

  _ViewModel copyWith({
    Teacher? tutor,
    ScheduleFilter? filter,
    List<Schedule>? schedules,
    List<Feedback>? feedbacks,
  }) {
    return _ViewModel(
      tutor: tutor ?? this.tutor,
      filter: filter ?? this.filter,
      schedules: schedules ?? this.schedules,
      feedbacks: feedbacks ?? this.feedbacks,
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
  List<Feedback> get feedbacks => viewModel.feedbacks;
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

class BookScheduleSuccessfulState extends TutorState {
  BookScheduleSuccessfulState({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

class FeedbackState extends TutorState {
  FeedbackState({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

class GetTutorState extends TutorState {
  GetTutorState({
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
  BookScheduleSuccessfulState: (viewModel) => BookScheduleSuccessfulState(
        viewModel: viewModel,
      ),
  FeedbackState: (viewModel) => FeedbackState(
        viewModel: viewModel,
      ),
  GetTutorState: (viewModel) => GetTutorState(
        viewModel: viewModel,
      ),
};
