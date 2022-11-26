part of 'wallet_bloc.dart';

class _ViewModel {
  final int? total;
  final String? firstTime;
  final int? count;
  final String? referralCode;
  final List<Payment> payment;
  final List<Statistic> statistics;
  final List<User> referralUsers;

  const _ViewModel({
    this.total,
    this.firstTime,
    this.count,
    this.referralCode,
    this.payment = const [],
    this.statistics = const [],
    this.referralUsers = const [],
  });

  _ViewModel copyWith({
    int? total,
    String? firstTime,
    int? count,
    String? referralCode,
    List<Payment>? payment,
    List<Statistic>? statistics,
    List<User>? referralUsers,
  }) {
    return _ViewModel(
      total: total ?? this.total,
      firstTime: firstTime ?? this.firstTime,
      count: count ?? this.count,
      referralCode: referralCode ?? this.referralCode,
      payment: payment ?? this.payment,
      statistics: statistics ?? this.statistics,
      referralUsers: referralUsers ?? this.referralUsers,
    );
  }
}

abstract class WalletState {
  final _ViewModel viewModel;

  WalletState(this.viewModel);

  T copyWith<T extends WalletState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == WalletState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }

  int? get total => viewModel.total;
  String? get firstTime => viewModel.firstTime;
  int? get count => viewModel.count;
  String? get referralCode => viewModel.referralCode;
  List<Payment>? get payment => viewModel.payment;
  List<Statistic>? get statistic => viewModel.statistics;
  List<User>? get referrals => viewModel.referralUsers;
}

class WalletInitial extends WalletState {
  WalletInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  WalletInitial: (viewModel) => WalletInitial(
        viewModel: viewModel,
      ),
};
