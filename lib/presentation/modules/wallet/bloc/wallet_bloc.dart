import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:let_tutor/data/models/payment.dart';
import 'package:let_tutor/data/models/statistic.dart';

import '../../../../data/data_source/remote/app_api_service.dart';
import '../../../../data/models/user.dart';
import '../../../../di/di.dart';
import '../../../base/base.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends AppBlocBase<WalletEvent, WalletState> {
  final _apiSerivce = injector.get<AppApiService>();

  WalletBloc() : super(WalletInitial(viewModel: const _ViewModel())) {
    on<InitialWalletEvent>(_onInitialWalletEvent);
    on<GetPaymentHistoryEvent>(_onGetPaymentHistoryEvent);
    on<GetPaymentStatisticEvent>(_onGetPaymentStatisticEvent);
    on<GetUserReferralEvent>(_onGetUserReferralEvent);
  }

  FutureOr<void> _onInitialWalletEvent(
    InitialWalletEvent event,
    Emitter<WalletState> emit,
  ) {
    add(GetPaymentHistoryEvent());
    add(GetPaymentStatisticEvent());
    add(GetUserReferralEvent());
  }

  FutureOr<void> _onGetPaymentHistoryEvent(
    GetPaymentHistoryEvent event,
    Emitter<WalletState> emit,
  ) async {
    final res = await _apiSerivce.client.getPaymentHistory();
    if (res != null) {
      emit(
        state.copyWith(
          viewModel: state.viewModel.copyWith(
            payment: res.data?.rows,
            count: res.data?.count,
          ),
        ),
      );
    }
  }

  FutureOr<void> _onGetPaymentStatisticEvent(
    GetPaymentStatisticEvent event,
    Emitter<WalletState> emit,
  ) async {
    final res = await _apiSerivce.client.getPaymentStatistics();
    if (res != null) {
      emit(
        state.copyWith(
          viewModel: state.viewModel.copyWith(
            firstTime: res.data?.firstTime,
            total: res.data?.total,
            statistics: res.data?.statistics,
          ),
        ),
      );
    }
  }

  FutureOr<void> _onGetUserReferralEvent(
    GetUserReferralEvent event,
    Emitter<WalletState> emit,
  ) async {
    final res = await _apiSerivce.client.getReferrals();
    if (res != null) {
      state.copyWith(
        viewModel: state.viewModel.copyWith(
          referralUsers: res,
        ),
      );
    }
  }
}
