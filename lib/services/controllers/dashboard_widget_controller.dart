import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DashboardInboxWidgetState { normal, isMaximized, isClosed }

enum DashboardDriversWidgetState { normal, isMaximized, isClosed }

final dashboardInboxWidgetController = AsyncNotifierProvider<
    DashboardInboxWidgetController, DashboardInboxWidgetState>(
  DashboardInboxWidgetController.new,
);

class DashboardInboxWidgetController
    extends AsyncNotifier<DashboardInboxWidgetState> {
  //!
  @override
  FutureOr<DashboardInboxWidgetState> build() =>
      DashboardInboxWidgetState.isClosed;

  void updateWidgetState({required DashboardInboxWidgetState newState}) =>
      state = AsyncValue.data(newState);
}

//!
//!
final dashboardDriversWidgetController = AsyncNotifierProvider<
    DashboardDriversWidgetController, DashboardDriversWidgetState>(
  DashboardDriversWidgetController.new,
);

class DashboardDriversWidgetController
    extends AsyncNotifier<DashboardDriversWidgetState> {
  //!
  @override
  FutureOr<DashboardDriversWidgetState> build() =>
      DashboardDriversWidgetState.isClosed;

  void updateWidgetState({required DashboardDriversWidgetState newState}) =>
      state = AsyncValue.data(newState);
}
