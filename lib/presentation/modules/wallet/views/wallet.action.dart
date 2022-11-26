part of 'wallet_screen.dart';

extension WalletAction on _WalletScreenState {
  void _blocListener(BuildContext context, WalletState state) {
    _refreshController
      ..refreshCompleted()
      ..loadComplete();
  }

  void onRefresh() {
    bloc.add(InitialWalletEvent());
  }

  void onTapReferralCode(String referralCode) async {
    await Clipboard.setData(ClipboardData(text: referralCode)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            trans.copiedToClipboard,
          ),
        ),
      );
    });
    // copied successfully
  }
}
