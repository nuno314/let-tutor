part of 'profile_bloc.dart';

class _ViewModel {
  const _ViewModel();

  _ViewModel copyWith() {
    return const _ViewModel();
  }
}

abstract class ProfileState {
  final _ViewModel viewModel;

  ProfileState(this.viewModel);

  T copyWith<T extends ProfileState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == ProfileState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }
}

class ProfileInitial extends ProfileState {
  ProfileInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  ProfileInitial: (viewModel) => ProfileInitial(
        viewModel: viewModel,
      ),
};