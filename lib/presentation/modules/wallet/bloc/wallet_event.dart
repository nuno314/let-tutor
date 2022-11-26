part of 'wallet_bloc.dart';

abstract class WalletEvent {}

class InitialWalletEvent extends WalletEvent {}

class GetPaymentHistoryEvent extends WalletEvent {}

class GetPaymentStatisticEvent extends WalletEvent {}

class GetUserReferralEvent extends WalletEvent {}
