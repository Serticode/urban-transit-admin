import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urban_transit_admin/screens/dashboard/drivers/dashboard_drivers.dart';
import 'package:urban_transit_admin/screens/dashboard/messaging/inbox_view.dart';
import 'package:urban_transit_admin/screens/dashboard/widget/app_multi_value_listenable_builder.dart';
import 'package:urban_transit_admin/shared/utils/app_extensions.dart';
import 'package:urban_transit_admin/shared/utils/app_fade_animation.dart';

//! GENERAL VALUE NOTIFIER TO SHOW ADMIN PAGE
ValueNotifier<bool> showAdminDashboard = ValueNotifier(false);

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen>
    with SingleTickerProviderStateMixin {
  ValueNotifier<bool> isMaximized = ValueNotifier(false);
  ValueNotifier<bool> isClosed = ValueNotifier(false);
  ValueNotifier<bool> isDriverMaximized = ValueNotifier(false);
  ValueNotifier<bool> isDriverClosed = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //! CHATS
        AppFadeAnimation(
            delay: 2.4,
            child: AppMultiListenableProvider(
              firstValue: isMaximized,
              secondValue: isClosed,
              child: const SizedBox.shrink(),
              builder: (context, firstValue, secondValue, child) =>
                  AnimatedAlign(
                      alignment: isMaximized.value
                          ? Alignment.topLeft
                          : Alignment.topRight,
                      duration: const Duration(milliseconds: 650),
                      curve: Curves.fastOutSlowIn,
                      child: ValueListenableBuilder(
                        valueListenable: isDriverMaximized,
                        builder: (context, value, child) =>
                            //! INBOX
                            DashboardInboxView(
                                height: (isMaximized.value == true &&
                                        isClosed.value == false)
                                    ? MediaQuery.of(context).size.height
                                    : (isMaximized.value == false &&
                                            isClosed.value == true)
                                        ? MediaQuery.of(context).size.height *
                                            0.1
                                        : (isDriverMaximized.value == true &&
                                                isMaximized.value == true)
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.1
                                            : MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.45,
                                //! MINIMIZE WIDGET
                                minimize: () => {
                                      isMaximized.value = false,
                                      isClosed.value = false
                                    },

                                //! MAXIMIZE WIDGET
                                maximize: () => isDriverMaximized.value == false
                                    ? {
                                        isMaximized.value = true,
                                        isClosed.value = false
                                      }
                                    : {},

                                //! CLOSE WIDGET
                                close: () => {
                                      isMaximized.value = false,
                                      isClosed.value = true
                                    }),
                      )),
            )),

        //! BASE - DRIVERS
        AppFadeAnimation(
          delay: 2.7,
          child: AppMultiListenableProvider(
            firstValue: isDriverMaximized,
            secondValue: isDriverClosed,
            child: const SizedBox.shrink(),
            builder: (context, firstValue, secondValue, child) => AnimatedAlign(
              alignment: isDriverMaximized.value
                  ? Alignment.topLeft
                  : Alignment.bottomRight,
              duration: const Duration(milliseconds: 650),
              curve: Curves.fastOutSlowIn,
              child: ValueListenableBuilder(
                valueListenable: isDriverClosed,
                builder: (context, value, child) => DashboardDrivers(
                  height: (isDriverMaximized.value == true &&
                          isDriverClosed.value == false)
                      ? MediaQuery.of(context).size.height
                      : (isDriverMaximized.value == false &&
                              isDriverClosed.value == true)
                          ? MediaQuery.of(context).size.height * 0.1
                          : (isDriverMaximized.value == true &&
                                  isMaximized.value == true)
                              ? MediaQuery.of(context).size.height * 0.1
                              : MediaQuery.of(context).size.height * 0.45,

                  //! MINIMIZE WIDGET
                  minimize: () => {
                    isDriverMaximized.value = false,
                    isDriverClosed.value = false
                  },

                  //! MAXIMIZE WIDGET
                  maximize: () => isMaximized.value == false
                      ? {
                          isDriverMaximized.value = true,
                          isDriverClosed.value = false
                        }
                      : {},

                  //! CLOSE WIDGET
                  close: () => {
                    isDriverMaximized.value = false,
                    isDriverClosed.value = true
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    ).generalPadding;
  }
}
