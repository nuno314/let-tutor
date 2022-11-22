part of 'sign_up_bloc.dart';

class _ViewModel {
  const _ViewModel();

  _ViewModel copyWith() {
    return const _ViewModel();
  }
}

abstract class SignUpState {
  final _ViewModel viewModel;

  SignUpState(this.viewModel);

  T copyWith<T extends SignUpState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == SignUpState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }
}

class SignUpInitial extends SignUpState {
  SignUpInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

class RegisterAccountSuccess extends SignUpState {
  RegisterAccountSuccess({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  SignUpInitial: (viewModel) => SignUpInitial(
        viewModel: viewModel,
      ),
  RegisterAccountSuccess: (viewModel) => RegisterAccountSuccess(
        viewModel: viewModel,
      ),
};
