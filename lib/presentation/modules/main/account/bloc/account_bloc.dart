import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/models/user.dart';
import '../../../../base/base.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends AppBlocBase<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial(viewModel: const _ViewModel())) {
    on<GetDataEvent>(_onGetDataEvent);
    on<LoadMoreDataEvent>(_onLoadMoreDataEvent);
  }

  Future<void> _onGetDataEvent(
    GetDataEvent event,
    Emitter<AccountState> emit,
  ) async {
    // final Accounts = await _interactor.getData();
    // emit(
    //   state.copyWith<AccountInitial>(
    //     viewModel: state.viewModel.copyWith(
    //       Accounts: Accounts,
    //       canLoadMore: _interactor.pagination.canNext,
    //     ),
    //   ),
    // );
  }

  Future<void> _onLoadMoreDataEvent(
    LoadMoreDataEvent event,
    Emitter<AccountState> emit,
  ) async {}
}
