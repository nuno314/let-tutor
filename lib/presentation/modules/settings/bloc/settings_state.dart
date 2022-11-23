part of 'settings_bloc.dart';

class _ViewModel {
  const _ViewModel();

  _ViewModel copyWith() {
    return const _ViewModel();
  }
}

abstract class SettingsState {
  final _ViewModel viewModel;

  SettingsState(this.viewModel);

  T copyWith<T extends SettingsState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == SettingsState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }
}

class SettingsInitial extends SettingsState {
  SettingsInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

class ChangeLanguageSuccess extends SettingsState {
  ChangeLanguageSuccess({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  SettingsInitial: (viewModel) => SettingsInitial(
        viewModel: viewModel,
      ),
  ChangeLanguageSuccess: (viewModel) => ChangeLanguageSuccess(
        viewModel: viewModel,
      ),
};
