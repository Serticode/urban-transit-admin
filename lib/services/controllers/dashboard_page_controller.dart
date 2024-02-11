import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DashboardDrawerPages {
  adminPage,
  dashboardPage,
  driversPage,
  notificationsPage,
  inflowPage,
}

final dashboardPageController =
    StateNotifierProvider<DashboardPageController, DashboardDrawerPages>(
  (ref) => DashboardPageController(),
);

class DashboardPageController extends StateNotifier<DashboardDrawerPages> {
  DashboardPageController() : super(DashboardDrawerPages.driversPage);

  void setCurrentPage({required DashboardDrawerPages currentPage}) =>
      state = currentPage;
}
