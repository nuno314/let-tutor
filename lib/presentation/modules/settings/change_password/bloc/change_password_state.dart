part of 'change_password_bloc.dart';

class _ViewModel {
  const _ViewModel();

  _ViewModel copyWith() {
    return const _ViewModel();
  }
}

abstract class ChangePasswordState {
  final _ViewModel viewModel;

  ChangePasswordState(this.viewModel);

  T copyWith<T extends ChangePasswordState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == ChangePasswordState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }
}

class ChangePasswordInitial extends ChangePasswordState {
  ChangePasswordInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

class ChangePasswordSuccess extends ChangePasswordState {
  ChangePasswordSuccess({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  ChangePasswordInitial: (viewModel) => ChangePasswordInitial(
        viewModel: viewModel,
      ),
  ChangePasswordSuccess: (viewModel) => ChangePasswordSuccess(
        viewModel: viewModel,
      ),
};
