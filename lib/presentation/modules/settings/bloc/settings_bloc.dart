import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';

import '../../../../di/di.dart';
import '../../../base/base.dart';
import '../../../common_bloc/app_data_bloc.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends AppBlocBase<SettingsEvent, SettingsState> {
  final _appDataBloc = injector.get<AppDataBloc>();

  SettingsBloc() : super(SettingsInitial(viewModel: const _ViewModel())) {
    on<SettingsEvent>(_onSettingsEvent);
    on<SetVietnameseLanguageEvent>(_onSetVietnameseLanguageEvent);
    on<SetEnglishLanguageEvent>(_onSetEnglishLanguageEvent);
  }

  Future<void> _onSettingsEvent(
    SettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {}

  FutureOr<void> _onSetVietnameseLanguageEvent(
    SetVietnameseLanguageEvent event,
    Emitter<SettingsState> emit,
  ) async {
    await _appDataBloc.changeLocale(
      Locale('vi'),
    );
    emit(ChangeLanguageSuccess());
  }

  FutureOr<void> _onSetEnglishLanguageEvent(
    SetEnglishLanguageEvent event,
    Emitter<SettingsState> emit,
  ) async {
    await _appDataBloc.changeLocale(
      Locale('en'),
    );
    emit(ChangeLanguageSuccess());
  }
}
