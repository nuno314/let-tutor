part of 'reset_password_bloc.dart';

class _ViewModel {
  final String? message;
  const _ViewModel({this.message});

  _ViewModel copyWith({String? message}) {
    return _ViewModel(
      message: message ?? this.message,
    );
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

  String? get message => viewModel.message;
}

class ResetPasswordInitial extends ResetPasswordState {
  ResetPasswordInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

class ResponseState extends ResetPasswordState {
  ResponseState({
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
  ResponseState: (viewModel) => ResponseState(
        viewModel: viewModel,
      ),
};
