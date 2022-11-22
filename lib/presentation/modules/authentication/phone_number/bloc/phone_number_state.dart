part of 'phone_number_bloc.dart';

class _ViewModel {
  const _ViewModel();

  _ViewModel copyWith() {
    return const _ViewModel();
  }
}

abstract class PhoneNumberState {
  final _ViewModel viewModel;

  PhoneNumberState(this.viewModel);

  T copyWith<T extends PhoneNumberState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == PhoneNumberState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }
}

class PhoneNumberInitial extends PhoneNumberState {
  PhoneNumberInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

class SignInSuccess extends PhoneNumberState {
  SignInSuccess({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  PhoneNumberInitial: (viewModel) => PhoneNumberInitial(
        viewModel: viewModel,
      ),
};