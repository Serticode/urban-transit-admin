import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:urban_transit_admin/screens/dashboard/admin/admin_information.dart';
import 'package:urban_transit_admin/screens/dashboard/dashboard.dart';
import 'package:urban_transit_admin/screens/dashboard/map/dashboard_map.dart';
import 'package:urban_transit_admin/screens/dashboard/widget/dashboard_drawer.dart';
import 'package:urban_transit_admin/screens/drivers/drivers_section.dart';
import 'package:urban_transit_admin/screens/drivers/widget/add_driver.dart';
import 'package:urban_transit_admin/screens/drivers/widget/show_driver_details.dart';
import 'package:urban_transit_admin/screens/inflow/inflow.dart';
import 'package:urban_transit_admin/screens/notifications/notification.dart';
import 'package:urban_transit_admin/screens/resize_to_desktop/resize_to_desktop.dart';
import 'package:urban_transit_admin/services/controllers/dashboard_page_controller.dart';
import 'package:urban_transit_admin/services/controllers/drawer_controller.dart';
import 'package:urban_transit_admin/services/controllers/drivers_page_controller.dart';
import 'package:urban_transit_admin/shared/utils/app_extensions.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class DashboardWrapper extends ConsumerStatefulWidget {
  const DashboardWrapper({super.key});

  @override
  ConsumerState<DashboardWrapper> createState() => _DashboardWrapperState();
}

class _DashboardWrapperState extends ConsumerState<DashboardWrapper>
    with SingleTickerProviderStateMixin {
  static const List<String> _menus = [
    "Dashboard",
    "Drivers",
    "Notifications",
    "Inflow"
  ];

  static const _menuIcons = [
    "lib/assets/icons/dashboard.svg",
    "lib/assets/icons/driver.svg",
    "lib/assets/icons/notifications.svg",
    "lib/assets/icons/inflow.svg",
  ];

  static const _initialDelayTime = Duration(milliseconds: 50);
  static const _itemSlideTime = Duration(milliseconds: 250);
  static const _staggerTime = Duration(milliseconds: 50);
  static const _buttonDelayTime = Duration(milliseconds: 150);
  static const _buttonTime = Duration(milliseconds: 650);
  final _animationDuration = _initialDelayTime +
      (_staggerTime * _menus.length) +
      _buttonDelayTime +
      _buttonTime;

  late AnimationController _staggeredController;
  final List<Interval> _itemSlideIntervals = [];

  @override
  void initState() {
    super.initState();
    _createAnimationIntervals();

    _staggeredController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..forward();
  }

  void _createAnimationIntervals() {
    for (var i = 0; i < _menus.length; ++i) {
      final startTime = _initialDelayTime + (_staggerTime * i);
      final endTime = startTime + _itemSlideTime;

      //! ADD SLIDE INTERVALS
      _itemSlideIntervals.add(
        Interval(startTime.inMilliseconds / _animationDuration.inMilliseconds,
            endTime.inMilliseconds / _animationDuration.inMilliseconds),
      );
    }
  }

  @override
  void dispose() {
    _staggeredController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentPage = ref.watch(dashboardPageController);
    final driversPageVisibleWidget =
        ref.watch(driversPageVisibleWidgetController);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      //!
      body: ResponsiveBuilder(
        builder: (context, sizingInformation) => (sizingInformation
                        .screenSize.width >=
                    1440 &&
                sizingInformation.screenSize.height >= 768)
            ? Stack(
                children: [
                  //! MAP
                  Visibility(
                    visible: currentPage.value ==
                            DashboardDrawerPages.dashboardPage ||
                        currentPage.value == DashboardDrawerPages.driversPage,
                    child: const DashboardMap(),
                  ),

                  //! DRAWER
                  Row(
                    children: [
                      DashboardDrawer(listItems: _buildListItems()),

                      //!
                      12.0.sizedBoxWidth,

                      Expanded(
                        child: currentPage.when(
                          data: (pageName) {
                            late Widget driversPageWidgetToBeShown;

                            if (pageName == DashboardDrawerPages.driversPage) {
                              final pageToBeShown =
                                  driversPageVisibleWidget.value;

                              switch (pageToBeShown) {
                                case DriversPageVisibleWidgetState.addNewDriver:
                                  driversPageWidgetToBeShown =
                                      const AddDriver();
                                  break;
                                case DriversPageVisibleWidgetState
                                      .driverDetails:
                                  driversPageWidgetToBeShown =
                                      const ShowDriverDetails();
                                  break;
                                case DriversPageVisibleWidgetState
                                      .driversAndInbox:
                                  driversPageWidgetToBeShown =
                                      const DriversSection();
                                  break;
                                default:
                                  const DriversSection();
                              }
                            }

                            return switch (pageName) {
                              DashboardDrawerPages.adminPage =>
                                const AdminInformation(),
                              DashboardDrawerPages.dashboardPage =>
                                const DashboardScreen(),
                              DashboardDrawerPages.driversPage =>
                                driversPageWidgetToBeShown,
                              DashboardDrawerPages.notificationsPage =>
                                const NotificationsScreen(),
                              DashboardDrawerPages.inflowPage => const Inflow(),
                            };
                          },
                          error: (error, stackTrace) =>
                              "$error $stackTrace".txt(),
                          loading: () => const CircularProgressIndicator(),
                        ),
                      )
                    ],
                  ),
                ],
              )

            //!
            : const ResizeToDesktopScreen(),
      ),
    );
  }

  //! BUILD THE LIST OF MENU ITEMS
  List<Widget> _buildListItems() {
    //! DECLARE THE PLACE HOLDER
    final List<Widget> listItems = <Widget>[];

    //! RUN A FOR LOOP, TO ADD ELEMENTS TO LIST
    for (var element in _menus) {
      listItems.add(
        //! ADD ANIMATED BUILDER, TO CARRY BASE ANIMATION
        AnimatedBuilder(
          animation: _staggeredController,
          builder: (context, child) {
            //! DECLARE VARIABLES NEEDED
            final animationPercent = Curves.easeOut.transform(
              _itemSlideIntervals[_menus.indexOf(element)]
                  .transform(_staggeredController.value),
            );
            final opacity = animationPercent;
            final slideDistance = (1.0 - animationPercent) * 150;

            //! RETURN OPACITY TO CREATE A SORT OF FADE TRANSITION
            return Opacity(
              opacity: opacity,
              child: Transform.translate(
                  offset: Offset(slideDistance, 0), child: child),
            );
          },

          //! ADD THE CHILD OF THE BUILDER; CARRYING THE MENU ITEM
          child: DashboardDrawerOption(
            isCurrentPage: DashboardDrawerPages.values
                    .indexOf(ref.watch(dashboardPageController).value!) ==
                _menus.indexOf(element) + 1,
            title: element,
            logo: _menuIcons.elementAt(_menus.indexOf(element)),
            logoColour: DashboardDrawerPages.values
                        .indexOf(ref.watch(dashboardPageController).value!) ==
                    _menus.indexOf(element) + 1
                ? AppThemeColours.appBlue
                : AppThemeColours.appGrey,
            onTap: () {
              ref.read(dashboardPageController.notifier).setCurrentPage(
                    currentPage: DashboardDrawerPages.values
                        .elementAt(_menus.indexOf(element) + 1),
                  );

              DashboardDrawerPages.values
                  .elementAt(_menus.indexOf(element) + 1)
                  .log();
            },
            isDrawerOpen: ref.watch(drawerOpenController).value!,
          ),
        ),
      );
    }
    return listItems;
  }
}
