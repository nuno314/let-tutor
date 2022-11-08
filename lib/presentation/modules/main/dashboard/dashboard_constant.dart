enum DashboardPage {
  home,
  booking,
  history,
  courses,
  account,
}

extension DashboardPageExt on DashboardPage {
  static bool guestCanView(int idx) {
    return [
      DashboardPage.home.index,
      DashboardPage.courses.index,
    ].contains(idx);
  }
}
