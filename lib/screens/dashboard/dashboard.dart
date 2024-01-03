import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urban_transit_admin/screens/dashboard/drivers/dashboard_drivers.dart';
import 'package:urban_transit_admin/screens/dashboard/messaging/inbox_view.dart';
import 'package:urban_transit_admin/services/controllers/dashboard_widget_controller.dart';
import 'package:urban_transit_admin/shared/utils/app_extensions.dart';
import 'package:urban_transit_admin/shared/utils/app_fade_animation.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardInboxWidgetState = ref.watch(dashboardInboxWidgetController);
    final dashboardDriversWidgetState =
        ref.watch(dashboardDriversWidgetController);

    return Stack(
      children: [
        //! CHATS
        dashboardInboxWidgetState.when(
          data: (widgetState) {
            return AppFadeAnimation(
              delay: 2.4,
              child: AnimatedAlign(
                alignment: widgetState == DashboardInboxWidgetState.isMaximized
                    ? Alignment.topLeft
                    : Alignment.topRight,
                duration: const Duration(milliseconds: 450),
                curve: Curves.fastOutSlowIn,

                //! INBOX
                child: DashboardInboxView(
                  height: widgetState == DashboardInboxWidgetState.isMaximized
                      ? MediaQuery.of(context).size.height
                      : widgetState == DashboardInboxWidgetState.isClosed
                          ? MediaQuery.of(context).size.height * 0.1
                          : MediaQuery.of(context).size.height * 0.45,

                  //! MINIMIZE WIDGET
                  minimize: () => ref
                      .read(dashboardInboxWidgetController.notifier)
                      .updateWidgetState(
                          newState: DashboardInboxWidgetState.normal),

                  //! MAXIMIZE WIDGET
                  maximize: () {
                    final isDriverMaximized =
                        ref.read(dashboardDriversWidgetController);

                    (isDriverMaximized.value ==
                                DashboardDriversWidgetState.isClosed ||
                            isDriverMaximized.value ==
                                DashboardDriversWidgetState.normal)
                        ? ref
                            .read(dashboardInboxWidgetController.notifier)
                            .updateWidgetState(
                                newState: DashboardInboxWidgetState.isMaximized)
                        : {};
                  },

                  //! CLOSE WIDGET
                  close: () => ref
                      .read(dashboardInboxWidgetController.notifier)
                      .updateWidgetState(
                        newState: DashboardInboxWidgetState.isClosed,
                      ),
                ),
              ),
            );
          },
          error: (error, stackTrace) => "$error $stackTrace".txt(),
          loading: () => const CircularProgressIndicator(),
        ),

        //! BASE - DRIVERS
        dashboardDriversWidgetState.when(
          data: (widgetState) {
            return AppFadeAnimation(
                delay: 2.7,
                child: AnimatedAlign(
                    alignment:
                        widgetState == DashboardDriversWidgetState.isMaximized
                            ? Alignment.topLeft
                            : Alignment.bottomRight,
                    duration: const Duration(milliseconds: 450),
                    curve: Curves.fastOutSlowIn,
                    child: DashboardDrivers(
                      height: widgetState ==
                              DashboardDriversWidgetState.isMaximized
                          ? MediaQuery.of(context).size.height
                          : widgetState == DashboardDriversWidgetState.isClosed
                              ? MediaQuery.of(context).size.height * 0.1
                              : MediaQuery.of(context).size.height * 0.45,

                      //! MINIMIZE WIDGET
                      minimize: () => ref
                          .read(dashboardDriversWidgetController.notifier)
                          .updateWidgetState(
                              newState: DashboardDriversWidgetState.normal),

                      //! MAXIMIZE WIDGET
                      maximize: () {
                        final isChatsMaximized =
                            ref.read(dashboardInboxWidgetController);

                        (isChatsMaximized.value ==
                                    DashboardInboxWidgetState.isClosed ||
                                isChatsMaximized.value ==
                                    DashboardInboxWidgetState.normal)
                            ? ref
                                .read(dashboardDriversWidgetController.notifier)
                                .updateWidgetState(
                                  newState:
                                      DashboardDriversWidgetState.isMaximized,
                                )
                            : {};
                      },

                      //! CLOSE WIDGET
                      close: () => ref
                          .read(dashboardDriversWidgetController.notifier)
                          .updateWidgetState(
                            newState: DashboardDriversWidgetState.isClosed,
                          ),
                    )));
          },
          error: (error, stackTrace) => "$error $stackTrace".txt(),
          loading: () => const CircularProgressIndicator(),
        )
      ],
    ).generalPadding;
  }
}
