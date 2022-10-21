part of 'reset_password_bloc.dart';

class _ViewModel {
  const _ViewModel();

  _ViewModel copyWith() {
    return const _ViewModel();
  }
}

abstract class ResetPasswordState {
  final _ViewModel viewModel;

  ResetPasswordState(this.viewModel);

  T copyWith<T extends ResetPasswordState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == ResetPasswordState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }
}

class ResetPasswordInitial extends ResetPasswordState {
  ResetPasswordInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  ResetPasswordInitial: (viewModel) => ResetPasswordInitial(
        viewModel: viewModel,
      ),
};