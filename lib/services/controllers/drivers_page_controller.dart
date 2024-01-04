import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DriversPageVisibleWidgetState {
  driversAndInbox,
  addNewDriver,
  driverDetails
}

final driversPageVisibleWidgetController = AsyncNotifierProvider<
    DriversPageVisibleWidgetController, DriversPageVisibleWidgetState>(
  DriversPageVisibleWidgetController.new,
);

class DriversPageVisibleWidgetController
    extends AsyncNotifier<DriversPageVisibleWidgetState> {
  //!
  @override
  FutureOr<DriversPageVisibleWidgetState> build() =>
      DriversPageVisibleWidgetState.driversAndInbox;

  void setVisibleWidget(
          {required DriversPageVisibleWidgetState visibleWidget}) =>
      state = AsyncValue.data(visibleWidget);
}
