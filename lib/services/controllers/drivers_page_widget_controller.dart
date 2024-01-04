import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DriversPageDriversWidgetState { normal, isMaximized, isClosed }

enum DriversPageInboxWidgetState { normal, isMaximized, isClosed }

final driversPageDriversWidgetController = AsyncNotifierProvider<
    DriversPageDriversWidgetController, DriversPageDriversWidgetState>(
  DriversPageDriversWidgetController.new,
);

class DriversPageDriversWidgetController
    extends AsyncNotifier<DriversPageDriversWidgetState> {
  //!
  @override
  FutureOr<DriversPageDriversWidgetState> build() =>
      DriversPageDriversWidgetState.isClosed;

  void updateWidgetState({required DriversPageDriversWidgetState newState}) =>
      state = AsyncValue.data(newState);
}

//!
//!
final driversPageInboxWidgetController = AsyncNotifierProvider<
    DriversPageInboxWidgetController, DriversPageInboxWidgetState>(
  DriversPageInboxWidgetController.new,
);

class DriversPageInboxWidgetController
    extends AsyncNotifier<DriversPageInboxWidgetState> {
  //!
  @override
  FutureOr<DriversPageInboxWidgetState> build() =>
      DriversPageInboxWidgetState.isClosed;

  void updateWidgetState({required DriversPageInboxWidgetState newState}) =>
      state = AsyncValue.data(newState);
}
