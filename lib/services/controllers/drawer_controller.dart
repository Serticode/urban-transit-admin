import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final drawerOpenController = AsyncNotifierProvider<DrawerOpenController, bool>(
  DrawerOpenController.new,
);

class DrawerOpenController extends AsyncNotifier<bool> {
  //!
  @override
  FutureOr<bool> build() => true;

  void isDrawerOpen({required bool isDrawerOpen}) =>
      state = AsyncValue.data(isDrawerOpen);
}
