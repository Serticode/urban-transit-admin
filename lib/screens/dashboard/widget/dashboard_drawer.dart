import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:urban_transit_admin/screens/dashboard/widget/drawer_icon.dart';
import 'package:urban_transit_admin/services/controllers/dashboard_page_controller.dart';
import 'package:urban_transit_admin/services/controllers/drawer_controller.dart';
import 'package:urban_transit_admin/shared/utils/app_extensions.dart';
import 'package:urban_transit_admin/shared/utils/app_images.dart';
import 'package:urban_transit_admin/shared/utils/app_screen_utils.dart';
import 'package:urban_transit_admin/shared/utils/app_texts.dart';
import 'package:urban_transit_admin/router/router.dart';
import 'package:urban_transit_admin/router/routes.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class DashboardDrawer extends ConsumerStatefulWidget {
  final List<Widget> listItems;
  const DashboardDrawer({
    super.key,
    required this.listItems,
  });

  @override
  ConsumerState<DashboardDrawer> createState() => _DashboardDrawerState();
}

class _DashboardDrawerState extends ConsumerState<DashboardDrawer>
    with SingleTickerProviderStateMixin {
  static const _menuTitles = [
    "Dashboard",
    "Drivers",
    "Notifications",
    "Inflow"
  ];

  static const _initialDelayTime = Duration(milliseconds: 50);
  static const _itemSlideTime = Duration(milliseconds: 250);
  static const _staggerTime = Duration(milliseconds: 50);
  static const _buttonDelayTime = Duration(milliseconds: 150);
  static const _buttonTime = Duration(milliseconds: 500);
  final _animationDuration = _initialDelayTime +
      (_staggerTime * _menuTitles.length) +
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
    for (var i = 0; i < _menuTitles.length; ++i) {
      final startTime = _initialDelayTime + (_staggerTime * i);
      final endTime = startTime + _itemSlideTime;

      //! ADD SLIDE INTERVALS
      _itemSlideIntervals.add(Interval(
          startTime.inMilliseconds / _animationDuration.inMilliseconds,
          endTime.inMilliseconds / _animationDuration.inMilliseconds));
    }
  }

  @override
  void dispose() {
    _staggeredController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final isDrawerOpen = ref.watch(drawerOpenController);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.fastOutSlowIn,
      width: isDrawerOpen ? 230 : 90,

      decoration: BoxDecoration(
        color: AppThemeColours.appWhiteBGColour,
        boxShadow: [
          BoxShadow(
            color: AppThemeColours.appGreyBGColour.withOpacity(0.2),
            blurRadius: 32.0.sp,
          )
        ],
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
      ),

      //! DRAWER
      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        shadowColor: AppThemeColours.appGreyBGColour.withOpacity(0.2),
        elevation: 12.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //! BACK BUTTON
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: const BoxDecoration(
                    color: AppThemeColours.appBlueTransparent,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      topLeft: Radius.circular(5.0),
                      bottomLeft: Radius.circular(5.0),
                    ),
                  ),
                  child: Icon(
                    isDrawerOpen
                        ? Icons.arrow_back_ios
                        : Icons.arrow_forward_ios,
                    size: 18.0.sp,
                    color: AppThemeColours.iconColour,
                  ).onTap(
                    onTap: () => ref
                        .read(drawerOpenController.notifier)
                        .isDrawerOpen(isDrawerOpen: !isDrawerOpen),
                  ),
                )
              ],
            ),

            //! SPACER
            AppScreenUtils.verticalSpaceMedium,

            //! APP LOGO
            !isDrawerOpen
                ? const DrawerIcon(imageURL: AppImages.urbanTransit)
                    .generalPadding
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        //! IMAGE
                        const DrawerIcon(imageURL: AppImages.urbanTransit),

                        //! SPACER
                        AppScreenUtils.horizontalSpaceSmall,

                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Visibility(
                              visible: isDrawerOpen,
                              child: Text(
                                AppTexts.urbanTransit,
                                style: textTheme.bodyLarge!
                                    .copyWith(fontSize: 14.0, height: 1.0),
                              ),
                            ),
                          ),
                        )
                      ]).generalPadding,

            //! SPACER
            AppScreenUtils.verticalSpaceMedium,

            //! DIVIDER
            const SizedBox(height: 0.8, child: Divider(thickness: 0.8)),

            //! SPACER
            AppScreenUtils.verticalSpaceMedium,

            //!
            //! OFFICE NAME
            !isDrawerOpen
                ? const DrawerIcon(imageURL: AppImages.nileAdmin)
                    .generalPadding
                    .onTap(
                      onTap: () => ref
                          .read(dashboardPageController.notifier)
                          .setCurrentPage(
                            currentPage: DashboardDrawerPages.adminPage,
                          ),
                    )
                : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                        //! ICON
                        const DrawerIcon(imageURL: AppImages.nileAdmin),

                        //! SPACER
                        AppScreenUtils.horizontalSpaceSmall,

                        //! TITLE
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Visibility(
                              visible: isDrawerOpen,
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: "Hello, ",
                                  style: textTheme.bodyMedium?.copyWith(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  children: [
                                    //!TODO: ADD CORRECT ADMIN NAME HERE
                                    TextSpan(
                                      text: AppTexts.nileAdmin,
                                      style: textTheme.bodyLarge!.copyWith(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]).generalPadding.onTap(
                      onTap: () => ref
                          .read(dashboardPageController.notifier)
                          .setCurrentPage(
                            currentPage: DashboardDrawerPages.adminPage,
                          ),
                    ),

            //! SPACER
            AppScreenUtils.verticalSpaceSmall,

            //! OTHER OPTIONS
            ...widget.listItems,

            const Spacer(),

            const SizedBox(height: 0.8, child: Divider(thickness: 0.8)),

            AppScreenUtils.verticalSpaceSmall,

            DashboardDrawerOption(
              title: "Logout",
              logo: AppImages.logOut,
              logoColour: AppThemeColours.appRed,
              isDrawerOpen: isDrawerOpen,
              isCurrentPage: null,
              onTap: () => AppNavigator.navigateToAndRemoveAllPreviousScreens(
                thePageRouteName: AppRoutes.loginScreen,
                context: context,
              ),
            ),

            //! SPACER
            AppScreenUtils.verticalSpaceMedium
          ],
        ),
      ),
    );
  }
}

//!
//!
//! DASHBOARD DRAWER OPTION
class DashboardDrawerOption extends StatelessWidget {
  final String title;
  final String logo;
  final Color logoColour;
  final bool? isCurrentPage;
  final bool isDrawerOpen;
  final void Function() onTap;
  const DashboardDrawerOption({
    super.key,
    required this.title,
    required this.logo,
    required this.onTap,
    required this.isDrawerOpen,
    required this.isCurrentPage,
    required this.logoColour,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      child: isDrawerOpen == false && isCurrentPage == true
          ? Transform.scale(
              scale: 0.75,
              filterQuality: FilterQuality.high,
              child: SvgPicture.asset(
                logo,
                colorFilter: ColorFilter.mode(logoColour, BlendMode.srcIn),
                fit: BoxFit.cover,
              ),
            ).generalPadding.onTap(onTap: onTap)
          : isDrawerOpen == false &&
                  (isCurrentPage == false || isCurrentPage == null)
              ? Transform.scale(
                  scale: 0.65,
                  filterQuality: FilterQuality.high,
                  child: SvgPicture.asset(
                    logo,
                    colorFilter: ColorFilter.mode(logoColour, BlendMode.srcIn),
                    fit: BoxFit.cover,
                  ),
                ).generalPadding.onTap(onTap: onTap)
              : SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(
                      vertical: 12.0.h,
                      horizontal: 21.0.w,
                    ),
                    child: Visibility(
                      visible: isDrawerOpen,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 30.0.w,
                            child: Transform.scale(
                              scale: 0.6,
                              filterQuality: FilterQuality.high,
                              child: SvgPicture.asset(
                                logo,
                                colorFilter: ColorFilter.mode(
                                    logoColour, BlendMode.srcIn),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          AppScreenUtils.horizontalSpaceMedium,

                          //!
                          Text(
                            title,
                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight:
                                  isCurrentPage != null && isCurrentPage!
                                      ? FontWeight.w500
                                      : FontWeight.w400,
                              color: isCurrentPage == null
                                  ? AppThemeColours.appRed
                                  : isCurrentPage == true
                                      ? AppThemeColours.appBlue
                                      : AppThemeColours.appGrey,
                            ),
                          ),
                        ],
                      ).onTap(
                        onTap: onTap,
                      ),
                    ),
                  ),
                ),
    );
  }
}
