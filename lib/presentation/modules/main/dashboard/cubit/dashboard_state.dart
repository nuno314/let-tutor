part of 'dashboard_cubit.dart';

abstract class DashboardState {
  final int index;

  // True => status bar color is white
  // False => status bar color is black
  bool get lighStatusBar;

  String get route;

  DashboardState(this.index);
}

class DashboardHome extends DashboardState {
  DashboardHome() : super(DashboardPage.home.index);

  @override
  bool get lighStatusBar => false;

  @override
  String get route => 'home';
}

class DashboardBooking extends DashboardState {
  DashboardBooking() : super(DashboardPage.booking.index);

  @override
  bool get lighStatusBar => false;

  @override
  String get route => 'cosmetic_list';
}

class DashboardHistory extends DashboardState {
  DashboardHistory() : super(DashboardPage.history.index);

  @override
  bool get lighStatusBar => false;

  @override
  String get route => 'history';
}

class DashboardCourses extends DashboardState {
  DashboardCourses() : super(DashboardPage.courses.index);
  @override
  bool get lighStatusBar => false;

  @override
  String get route => 'courses';
}

class DashboardAccount extends DashboardState {
  DashboardAccount() : super(DashboardPage.account.index);
  @override
  bool get lighStatusBar => false;

  @override
  String get route => 'account';
}
