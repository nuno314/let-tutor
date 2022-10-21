part of '../base.dart';

extension StateBaseExtention on StateBase {
  void hideKeyBoard() => CommonFunction.hideKeyBoard(context);

  Size get device => MediaQuery.of(context).size;

  double get paddingTop => MediaQuery.of(context).padding.top;

  double get paddingBottom => MediaQuery.of(context).padding.bottom;

  void backToHome() {
    Navigator.of(context).popUntil(
      ModalRoute.withName(RouteList.dashBoardRoute),
    );
  }

}

void showToast(String message) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: const Color(0xffCCECF9),
    textColor: Colors.black,
    fontSize: 12.0,
  );
}
