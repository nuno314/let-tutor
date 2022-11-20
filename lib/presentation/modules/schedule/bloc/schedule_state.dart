part of 'schedule_bloc.dart';

class _ViewModel {
  final List<Session> sessions;
  final List<Document> documents;
  const _ViewModel({
    this.sessions = const [],
    this.documents = const [],
  });

  _ViewModel copyWith(
    List<Session>? sessions,
    List<Document>? documents,
  ) {
    return _ViewModel(
      sessions: sessions ?? this.sessions,
      documents: documents ?? this.documents,
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

  List<Session> get sessions => viewModel.sessions;
  List<Document> get documents => viewModel.documents;
}

class ScheduleInitial extends ScheduleState {
  ScheduleInitial({
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
};
