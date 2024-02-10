import 'package:flutter_riverpod/flutter_riverpod.dart';

final drawerOpenController = StateNotifierProvider<DrawerOpenController, bool>(
  (ref) => DrawerOpenController(),
);

class DrawerOpenController extends StateNotifier<bool> {
  DrawerOpenController() : super(true);

  void isDrawerOpen({required bool isDrawerOpen}) => state = isDrawerOpen;
}
