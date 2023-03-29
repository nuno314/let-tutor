part of 'register_tutor_bloc.dart';

class _ViewModel {
  const _ViewModel();

  _ViewModel copyWith() {
    return const _ViewModel();
  }
}

abstract class RegisterTutorState {
  final _ViewModel viewModel;

  RegisterTutorState(this.viewModel);

  T copyWith<T extends RegisterTutorState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == RegisterTutorState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }
}

class RegisterTutorInitial extends RegisterTutorState {
  RegisterTutorInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  RegisterTutorInitial: (viewModel) => RegisterTutorInitial(
        viewModel: viewModel,
      ),
};
