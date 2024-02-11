import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DriversPageDriversWidgetState { normal, isMaximized, isClosed }

enum DriversPageInboxWidgetState { normal, isMaximized, isClosed }

final driversPageDriversWidgetController = StateNotifierProvider<
    DriversPageDriversWidgetController, DriversPageDriversWidgetState>(
  (ref) => DriversPageDriversWidgetController(),
);

class DriversPageDriversWidgetController
    extends StateNotifier<DriversPageDriversWidgetState> {
  DriversPageDriversWidgetController()
      : super(DriversPageDriversWidgetState.isClosed);

  void updateWidgetState({required DriversPageDriversWidgetState newState}) =>
      state = newState;
}

//!
//!
final driversPageInboxWidgetController = StateNotifierProvider<
    DriversPageInboxWidgetController, DriversPageInboxWidgetState>(
  (ref) => DriversPageInboxWidgetController(),
);

class DriversPageInboxWidgetController
    extends StateNotifier<DriversPageInboxWidgetState> {
  DriversPageInboxWidgetController()
      : super(DriversPageInboxWidgetState.isClosed);

  void updateWidgetState({required DriversPageInboxWidgetState newState}) =>
      state = newState;
}
