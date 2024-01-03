import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urban_transit_admin/shared/utils/app_fade_animation.dart';
import 'package:urban_transit_admin/shared/utils/app_images.dart';
import 'package:urban_transit_admin/shared/utils/app_screen_utils.dart';
import 'package:urban_transit_admin/shared/utils/app_texts.dart';
import 'package:urban_transit_admin/shared/utils/custom_container_headers.dart';
import 'package:urban_transit_admin/shared/utils/profile_image.dart';
import 'package:urban_transit_admin/screens/dashboard/messaging/dashboard_messaging.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class DashboardInboxView extends StatefulWidget {
  final void Function() minimize;
  final void Function() maximize;
  final void Function() close;
  final double? height;
  final bool? isNotificationScreen;
  const DashboardInboxView(
      {super.key,
      required this.minimize,
      required this.maximize,
      required this.close,
      this.height,
      this.isNotificationScreen});
  @override
  State<DashboardInboxView> createState() => _DashboardInboxViewState();
}

class _DashboardInboxViewState extends State<DashboardInboxView> {
  int currentPage = 0;
  final PageController _controller = PageController();
  //! DEFINITIONS
  static const List<IconData> menuIcons = [
    Icons.remove,
    Icons.open_in_full,
    Icons.close
  ];

  static final List<Color> menuIconColours = [
    Colors.grey.shade800,
    AppThemeColours.appGreen,
    AppThemeColours.appRed
  ];

  static const List<Color> menuIconBGColour = [
    AppThemeColours.appGreyBGColour,
    AppThemeColours.appGreenTransparent,
    AppThemeColours.appRedTransparent
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 450),
        curve: Curves.fastOutSlowIn,
        width: 400.0.w,
        height: widget.height ?? 500.0.h,
        padding: AppScreenUtils.containerPaddingSmall,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0.r),
            color: AppThemeColours.appWhiteBGColour,
            boxShadow: [
              BoxShadow(
                  color: AppThemeColours.appGreyBGColour.withOpacity(0.8),
                  blurRadius: 32.0.sp)
            ]),
        child: widget.height == MediaQuery.of(context).size.height * 0.1
            ? AppFadeAnimation(
                delay: 1.2,
                child: Row(
                  children: [
                    //! TITLE
                    Text(
                      AppTexts.inbox,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 18.0.sp,
                            fontWeight: FontWeight.w600,
                          ),
                    ),

                    //! SPACER
                    const Spacer(),

                    //! BUTTONS - MINIMIZE
                    ...menuIcons.map(
                      (icon) => Padding(
                        padding: EdgeInsets.only(right: 6.0.sp),
                        child: InkWell(
                          onTap: () => menuIconOnTapTrigger(
                              index: menuIcons.indexOf(icon)),
                          child: CircleAvatar(
                            radius: 14.0.r,
                            backgroundColor: menuIconBGColour
                                .elementAt(menuIcons.indexOf(icon)),
                            child: Icon(
                              icon,
                              size: 12.0.sp,
                              color: menuIconColours.elementAt(
                                menuIcons.indexOf(icon),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Column(children: [
                CustomContainerHeaders(
                  title:
                      currentPage == 0 ? AppTexts.inbox : AppTexts.chatsHeader,
                  minimize: () => widget.minimize(),
                  maximize: () => widget.maximize(),
                  close: () => widget.close(),
                ),

                //! SPACER
                AppScreenUtils.verticalSpaceMedium,

                //! OTHER BODY
                Expanded(
                    child: PageView(
                        controller: _controller,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                      InkWell(
                        onTap: () {
                          setState(() => currentPage > 0
                              ? currentPage = 0
                              : currentPage++);

                          _controller.animateToPage(currentPage,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeInSine);
                        },
                        child: MainInboxView(
                            isNotificationScreen: widget.isNotificationScreen,
                            onTap: () {}),
                      ),

                      //! MESSAGES
                      DashboardMessaging(
                        onTap: () {
                          setState(() => currentPage = 0);

                          _controller.animateToPage(currentPage,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeInSine);
                        },
                      )
                    ]))
              ]));
  }

  void menuIconOnTapTrigger({required int index}) {
    switch (index) {
      case 0:
        widget.minimize();
        break;
      case 1:
        widget.maximize();
        break;
      case 2:
        widget.close();
        break;
      default:
    }
  }
}

//!
//!
//! MAIN INBOX VIEW
class MainInboxView extends StatelessWidget {
  final void Function() onTap;
  final bool? isNotificationScreen;
  const MainInboxView(
      {super.key, required this.onTap, this.isNotificationScreen});

  @override
  Widget build(BuildContext context) {
    return //! SPACER
        ListView.builder(
      itemCount: 14,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0.sp),
        child: InboxItem(
            onTap: () {},
            isNotificationScreen: isNotificationScreen,
            index: index + 1),
      ),
    );
  }
}

//!
//!
//! INBOX ITEM
class InboxItem extends StatelessWidget {
  final int? index;
  final void Function() onTap;
  final bool? isNotificationScreen;
  const InboxItem(
      {super.key, required this.onTap, this.index, this.isNotificationScreen});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(children: [
      //! PROFILE PHOTO
      ProfilePhotoWidget(
        imageURL: index!.isEven
            ? AppImages.user2
            : index! / 3 == 0
                ? AppImages.user3
                : AppImages.user1,
      ),

      //! SPACER
      AppScreenUtils.horizontalSpaceSmall,

      //! COLUMN - MESSAGE PREVIEW
      Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //! USER NAME
          Text("User $index",
              style: textTheme.bodyLarge!.copyWith(
                  fontSize: isNotificationScreen != null &&
                          isNotificationScreen == true
                      ? 16.0.sp
                      : 14.0.sp,
                  height: 1.0.sp)),

          //! SPACER
          AppScreenUtils.verticalSpaceSmall,

          //! MESSAGE PREVIEW
          Wrap(
            children: [
              Text(
                "Morbi leo risus, porta ac consectetur ac,vestibulum at eros. Aenean lacinia bibendum nulla sed consectetur.....",
                style: textTheme.bodyMedium!.copyWith(
                    fontSize: isNotificationScreen != null &&
                            isNotificationScreen == true
                        ? 14.0.sp
                        : 12.0.sp,
                    height: 1.8.sp),
              ),
            ],
          ),
        ]),
      ),

      //! SPACER
      AppScreenUtils.horizontalSpaceSmall,

      //! TIME AND
      Text("9:00am",
          style: textTheme.bodyMedium!.copyWith(
              fontSize:
                  isNotificationScreen != null && isNotificationScreen == true
                      ? 14.0.sp
                      : 12.0.sp,
              height: 1.0.sp,
              color: AppThemeColours.appGreen))
    ]);
  }
}
