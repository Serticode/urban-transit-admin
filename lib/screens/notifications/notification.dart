import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urban_transit_admin/shared/utils/app_fade_animation.dart';
import 'package:urban_transit_admin/shared/utils/app_screen_utils.dart';
import 'package:urban_transit_admin/shared/utils/app_texts.dart';
import 'package:urban_transit_admin/shared/utils/custom_container_headers.dart';
import 'package:urban_transit_admin/screens/dashboard/messaging/dashboard_messaging.dart';
import 'package:urban_transit_admin/screens/dashboard/messaging/inbox_view.dart';
import 'package:urban_transit_admin/screens/inflow/widget/current_flow.dart';
import 'package:urban_transit_admin/screens/notifications/widget/notification_chat_view.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: AppScreenUtils.containerPadding,
        child: Row(children: [
          //! LEFT SIDE -  CHATS AND INFLOW
          Expanded(
              child: Column(children: [
            const Expanded(
              child: AppFadeAnimation(
                delay: 1.2,
                child: NotificationListOfChats(),
              ),
            ),

            //! SPACER
            AppScreenUtils.verticalSpaceMedium,

            //! CURRENT INFLOW
            const Expanded(
              child: AppFadeAnimation(
                delay: 1.4,
                child: NotificationInflow(),
              ),
            )
          ])),

          //! SPACER
          AppScreenUtils.horizontalSpaceMedium,

          //! RIGHT SIDE - CHAT DETAILS OF USER CLICKED ON THE RIGHT SIDE.
          const Expanded(
            child: AppFadeAnimation(
              delay: 1.6,
              child: NotificationScreenChatDetails(),
            ),
          )
        ]));
  }
}

//! NOTIFICATION - LIST OF CHATS
class NotificationListOfChats extends ConsumerWidget {
  const NotificationListOfChats({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //! TEXT STYLE
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      height: 600.0.h,
      padding: AppScreenUtils.containerPaddingCustom,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0.r),
          boxShadow: <BoxShadow>[
            BoxShadow(
                blurRadius: 6.0.r,
                spreadRadius: 12.0.r,
                color: Colors.grey.shade100)
          ]),
      child: Column(
        children: [
          //! TITLE
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Chats",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 18.0.sp,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),

          //! SPACER
          AppScreenUtils.verticalSpaceSmall,

          Divider(
            thickness: 2.0.h,
            height: 2.0.h,
            color: AppThemeColours.backgroundColourGrey,
          ),

          //! SPACER
          AppScreenUtils.verticalSpaceSmall,

          //! DATE AND TIME
          Text("Wednesday 23rd May,2022",
              style: textTheme.bodyLarge!.copyWith(fontSize: 12.0.sp)),

          //! SPACER
          AppScreenUtils.verticalSpaceSmall,

          //! CHAT LIST
          Expanded(
            child: MainInboxView(
              isNotificationScreen: true,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

//! NOTIFICATION - LIST OF CHATS
class NotificationChatList extends StatefulWidget {
  final void Function() minimize;
  final void Function() maximize;
  final void Function() close;
  final double? height;
  const NotificationChatList(
      {super.key,
      required this.minimize,
      required this.maximize,
      required this.close,
      this.height});
  @override
  State<NotificationChatList> createState() => _NotificationChatListState();
}

class _NotificationChatListState extends State<NotificationChatList> {
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
    //! TEXT STYLE
    final TextTheme textTheme = Theme.of(context).textTheme;

    return AnimatedContainer(
        duration: const Duration(milliseconds: 650),
        curve: Curves.fastOutSlowIn,
        width: 350.0.w,
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
                child: Row(children: [
                  //! TITLE
                  Text(AppTexts.inbox,
                      style:
                          textTheme.displayLarge!.copyWith(fontSize: 21.0.sp)),

                  //! SPACER
                  const Spacer(),

                  //! BUTTONS - MINIMIZE
                  ...menuIcons.map((icon) => Padding(
                      padding: EdgeInsets.only(right: 6.0.sp),
                      child: InkWell(
                          onTap: () => menuIconOnTapTrigger(
                              index: menuIcons.indexOf(icon)),
                          child: CircleAvatar(
                              radius: 14.0.r,
                              backgroundColor: menuIconBGColour
                                  .elementAt(menuIcons.indexOf(icon)),
                              child: Icon(icon,
                                  size: 12.0.sp,
                                  color: menuIconColours
                                      .elementAt(menuIcons.indexOf(icon)))))))
                ]))
            : Column(children: [
                CustomContainerHeaders(
                    title: currentPage == 0
                        ? AppTexts.inbox
                        : AppTexts.chatsHeader,
                    minimize: () => widget.minimize(),
                    maximize: () => widget.maximize(),
                    close: () => widget.close()),

                //! OTHER BODY
                Expanded(
                    child: PageView(
                        controller: _controller,
                        physics: const BouncingScrollPhysics(),
                        children: [
                      InkWell(
                        onTap: () {
                          setState(() => currentPage > 0
                              ? currentPage = 0
                              : currentPage++);

                          _controller.animateToPage(currentPage,
                              duration: const Duration(milliseconds: 350),
                              curve: Curves.easeInSine);
                        },
                        child: MainInboxView(
                          isNotificationScreen: true,
                          onTap: () {},
                        ),
                      ),

                      //! MESSAGES
                      //!TODO:
                      DashboardMessaging(
                        onTap: () {},
                      )
                    ])),
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

//! NOTIFICATION - INFLOW
class NotificationInflow extends ConsumerWidget {
  const NotificationInflow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        height: 350.0.h,
        padding: AppScreenUtils.containerPaddingCustom,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0.r),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  blurRadius: 6.0.r,
                  spreadRadius: 12.0.r,
                  color: Colors.grey.shade100)
            ]),
        child: Column(children: [
          //! TITLE
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Current Inflow",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 18.0.sp,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),

          //! SPACER
          AppScreenUtils.verticalSpaceSmall,

          Divider(
            thickness: 2.0.h,
            height: 2.0.h,
            color: AppThemeColours.backgroundColourGrey,
          ),

          //! SPACER
          AppScreenUtils.verticalSpaceSmall,

          //! INFLOW - CURRENT FLOW
          Expanded(
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                      children: List.generate(
                          8, (index) => CurrentFlowWidget(index: index)))))
        ]));
  }
}

//! NOTIFICATION SCREEN CHAT DETAILS OF USER CLICKED ON THE RIGHT SIDE.
class NotificationScreenChatDetails extends ConsumerWidget {
  const NotificationScreenChatDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        height: 950.0.h,
        width: 620.0.w,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0.r),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  blurRadius: 6.0.r,
                  spreadRadius: 12.0.r,
                  color: Colors.grey.shade100)
            ]),
        padding: AppScreenUtils.containerPadding,
        child: Column(children: [
          //! TITLE
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Chats",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 18.0.sp,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),

          //! SPACER
          AppScreenUtils.verticalSpaceSmall,

          Divider(
            thickness: 2.0.h,
            height: 2.0.h,
            color: AppThemeColours.backgroundColourGrey,
          ),

          //! SPACER
          AppScreenUtils.verticalSpaceSmall,

          //! BODY
          const Expanded(child: NotificationChatView())
        ]));
  }
}
