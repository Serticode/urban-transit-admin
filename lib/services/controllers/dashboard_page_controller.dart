import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DashboardDrawerPages {
  adminPage,
  dashboardPage,
  driversPage,
  notificationsPage,
  inflowPage,
}

final dashboardPageController =
    AsyncNotifierProvider<DashboardPageController, DashboardDrawerPages>(
  DashboardPageController.new,
);

class DashboardPageController extends AsyncNotifier<DashboardDrawerPages> {
  //!
  @override
  FutureOr<DashboardDrawerPages> build() => DashboardDrawerPages.driversPage;

  void setCurrentPage({required DashboardDrawerPages currentPage}) =>
      state = AsyncValue.data(currentPage);
}
