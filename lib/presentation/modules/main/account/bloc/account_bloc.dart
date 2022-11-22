import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/data/data_source/local/local_data_manager.dart';
import 'package:let_tutor/data/data_source/remote/app_api_service.dart';

import '../../../../../data/models/user.dart';
import '../../../../../di/di.dart';
import '../../../../base/base.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends AppBlocBase<AccountEvent, AccountState> {
  final _apiSerivce = injector.get<AppApiService>();

  AccountBloc()
      : super(
          AccountInitial(
            viewModel: _ViewModel(
              user: injector.get<LocalDataManager>().currentUser,
            ),
          ),
        ) {
    on<GetDataEvent>(_onGetDataEvent);
  }

  Future<void> _onGetDataEvent(
    GetDataEvent event,
    Emitter<AccountState> emit,
  ) async {
    final res = await _apiSerivce.client.getUserInfomation({});
    emit(
      state.copyWith(
        viewModel: state.viewModel.copyWith(
          user: res?.user,
        ),
      ),
    );
  }
}
