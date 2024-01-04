import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urban_transit_admin/screens/widgets/call_dialogue.dart';
import 'package:urban_transit_admin/services/controllers/drivers_page_controller.dart';
import 'package:urban_transit_admin/services/controllers/drivers_page_widget_controller.dart';
import 'package:urban_transit_admin/shared/utils/app_extensions.dart';
import 'package:urban_transit_admin/shared/utils/app_fade_animation.dart';
import 'package:urban_transit_admin/shared/utils/app_images.dart';
import 'package:urban_transit_admin/shared/utils/app_screen_utils.dart';
import 'package:urban_transit_admin/shared/utils/app_texts.dart';
import 'package:urban_transit_admin/shared/utils/profile_image.dart';
import 'package:urban_transit_admin/screens/dashboard/messaging/inbox_view.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class DriversSection extends ConsumerWidget {
  const DriversSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final driversPageDriversWidgetState =
        ref.watch(driversPageDriversWidgetController);
    final driversPageInboxWidgetState =
        ref.watch(driversPageInboxWidgetController);

    return Padding(
      padding: AppScreenUtils.containerPaddingSmall,
      child: Stack(children: [
        //! MESSAGES
        driversPageInboxWidgetState.when(
          data: (widgetState) {
            return AppFadeAnimation(
              delay: 2.4,
              child: AnimatedAlign(
                alignment: Alignment.topRight,
                duration: const Duration(milliseconds: 450),
                curve: Curves.fastOutSlowIn,

                //! INBOX
                child: DashboardInboxView(
                  height: widgetState == DriversPageInboxWidgetState.isMaximized
                      ? MediaQuery.of(context).size.height
                      : widgetState == DriversPageInboxWidgetState.isClosed
                          ? MediaQuery.of(context).size.height * 0.1
                          : MediaQuery.of(context).size.height * 0.45,

                  //! MINIMIZE WIDGET
                  minimize: () => ref
                      .read(driversPageInboxWidgetController.notifier)
                      .updateWidgetState(
                        newState: DriversPageInboxWidgetState.normal,
                      ),

                  //! MAXIMIZE WIDGET
                  maximize: () => ref
                      .read(driversPageInboxWidgetController.notifier)
                      .updateWidgetState(
                        newState: DriversPageInboxWidgetState.isMaximized,
                      ),

                  //! CLOSE WIDGET
                  close: () => ref
                      .read(driversPageInboxWidgetController.notifier)
                      .updateWidgetState(
                        newState: DriversPageInboxWidgetState.isClosed,
                      ),
                ),
              ),
            );
          },
          error: (error, stackTrace) => "$error $stackTrace".txt(),
          loading: () => const CircularProgressIndicator(),
        ),

        //! LIST OF DRIVERS
        driversPageDriversWidgetState.when(
          data: (widgetState) => AppFadeAnimation(
            delay: 2.7,
            child: Align(
              alignment: Alignment.topLeft,
              child: ListOfDriversAndDetails(
                height: widgetState == DriversPageDriversWidgetState.isMaximized
                    ? MediaQuery.of(context).size.height
                    : widgetState == DriversPageDriversWidgetState.isClosed
                        ? MediaQuery.of(context).size.height * 0.1
                        : MediaQuery.of(context).size.height * 0.45,

                //! MINIMIZE WIDGET
                minimize: () => ref
                    .read(driversPageDriversWidgetController.notifier)
                    .updateWidgetState(
                      newState: DriversPageDriversWidgetState.normal,
                    ),

                //! MAXIMIZE WIDGET
                maximize: () => ref
                    .read(driversPageDriversWidgetController.notifier)
                    .updateWidgetState(
                      newState: DriversPageDriversWidgetState.isMaximized,
                    ),

                //! CLOSE WIDGET
                close: () => ref
                    .read(driversPageDriversWidgetController.notifier)
                    .updateWidgetState(
                      newState: DriversPageDriversWidgetState.isClosed,
                    ),
              ),
            ),
          ),
          error: (error, stackTrace) => "$error $stackTrace".txt(),
          loading: () => const CircularProgressIndicator(),
        ),
      ]),
    );
  }
}

class ListOfDriversAndDetails extends ConsumerWidget {
  final double? height;
  final void Function() minimize;
  final void Function() maximize;
  final void Function() close;
  const ListOfDriversAndDetails(
      {super.key,
      this.height,
      required this.minimize,
      required this.maximize,
      required this.close});
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
  Widget build(BuildContext context, WidgetRef ref) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return AnimatedContainer(
      padding: AppScreenUtils.containerPaddingSmall,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0.r),
          color: AppThemeColours.appWhiteBGColour,
          boxShadow: [
            BoxShadow(
                color: AppThemeColours.appGreyBGColour.withOpacity(0.8),
                blurRadius: 32.0.sp)
          ]),
      duration: const Duration(milliseconds: 450),
      curve: Curves.fastOutSlowIn,
      height: height ?? 500.0.h,
      width: 350.0.w,
      child: height == MediaQuery.of(context).size.height * 0.1
          ? AppFadeAnimation(
              delay: 1.2,
              child: Row(children: [
                //! TITLE
                Text(
                  AppTexts.drivers,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 18.0.sp,
                        fontWeight: FontWeight.w600,
                      ),
                ),

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
          : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //! TITLE
              AppFadeAnimation(
                  delay: 1.2,
                  child: Row(children: [
                    //! TITLE
                    Text(
                      AppTexts.drivers,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 18.0.sp,
                            fontWeight: FontWeight.w600,
                          ),
                    ),

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
                  ])),

              //! SPACER
              AppScreenUtils.verticalSpaceSmall,

              //! CONTENT - NUMBER OF ACTIVE DRIVERS
              //! TITLE
              Text(
                "24 ${AppTexts.drivers}",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 16.0.sp,
                    ),
              ),

              //! SPACER
              AppScreenUtils.verticalSpaceSmall,

              //! NUMBER OF ACTIVE OFF DUTY AND SUSPENDED
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("8 Currently in transit,",
                    style: textTheme.bodyMedium!.copyWith(
                        fontSize: 12.0.sp, color: AppThemeColours.appGreen)),

                //! SPACER
                AppScreenUtils.horizontalSpaceSmall,

                Text("6 Off Duty,",
                    style: textTheme.bodyMedium!.copyWith(
                        fontSize: 12.0.sp, color: AppThemeColours.appAmber)),

                //! SPACER
                AppScreenUtils.horizontalSpaceSmall,

                Text("10 Suspended",
                    style: textTheme.bodyMedium!.copyWith(
                        fontSize: 12.0.sp, color: AppThemeColours.appRed)),
              ]),

              //! SPACER
              AppScreenUtils.verticalSpaceSmall,

              //! ROW - FILTER AND ADD NEW DRIVER
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                //! ADD BUTTON
                InkWell(
                  //! ADD DRIVER
                  onTap: () => ref
                      .read(driversPageVisibleWidgetController.notifier)
                      .setVisibleWidget(
                        visibleWidget:
                            DriversPageVisibleWidgetState.addNewDriver,
                      ),
                  /* AppScreenUtils.showAppDialogBox(
                      theBuildContext: context,
                      width: 832.0.w,
                      height: 910.h,
                      child: const AddDriver()), */

                  //! OTHERS
                  child: Container(
                    padding: EdgeInsets.all(8.0.sp),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0.r),
                        border: Border.all(
                            width: 0.8.sp, color: AppThemeColours.appGreen)),
                    child: Row(
                      children: [
                        //! ICON
                        Icon(Icons.add,
                            size: 14.0.sp, color: AppThemeColours.appGreen),

                        //! SPACER
                        AppScreenUtils.horizontalSpaceSmall,

                        //! TEXT
                        Text("Add New Driver",
                            style: textTheme.bodyMedium!.copyWith(
                                fontSize: 12.0.sp,
                                height: 1.0.sp,
                                color: AppThemeColours.appGreen))
                      ],
                    ),
                  ),
                ),

                //! SPACER
                const Spacer(),

                //! FILTER
                CircleAvatar(
                    radius: 16.0.r,
                    backgroundColor: AppThemeColours.appBlue,
                    child: Icon(Icons.filter_list,
                        size: 16.0.sp, color: AppThemeColours.appWhiteBGColour))
              ]),

              //! SPACER
              AppScreenUtils.verticalSpaceMedium,

              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(
                      16,
                      (index) => InkWell(
                        onTap: () => ref
                            .read(driversPageVisibleWidgetController.notifier)
                            .setVisibleWidget(
                              visibleWidget:
                                  DriversPageVisibleWidgetState.driverDetails,
                            ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                          child: DriverItemWidget(
                              driversFullName: "Driver $index",
                              driversID: "Drivers ID - 123${index}45drive",
                              driverStatus: index / 3 == 0
                                  ? "Off Duty"
                                  : index.isEven
                                      ? "In Transit"
                                      : "Suspended",
                              imageURL: AppImages.drivers),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
    );
  }

  void menuIconOnTapTrigger({required int index}) {
    switch (index) {
      case 0:
        minimize();
        break;
      case 1:
        maximize();
        break;
      case 2:
        close();
        break;
      default:
    }
  }
}

class DriverItemWidget extends StatelessWidget {
  final String driversFullName;
  final String driversID;
  final String driverStatus;
  final String imageURL;
  const DriverItemWidget(
      {super.key,
      required this.driversFullName,
      required this.driversID,
      required this.driverStatus,
      required this.imageURL});

  @override
  Widget build(BuildContext context) {
//! TEXT THEME DEFINITION
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(children: [
      //! PHOTO WIDGET
      const ProfilePhotoWidget(imageURL: AppImages.inflow),

      //! SPACER
      AppScreenUtils.horizontalSpaceSmall,

      //! DETAILS
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //! FULL NAME
        Text(driversFullName,
            style: textTheme.bodyLarge!.copyWith(fontSize: 14.0.sp)),

        //! DRIVERS ID - NOTICE
        Text("Drivers ID",
            style: textTheme.bodyMedium!.copyWith(fontSize: 12.0.sp)),

        //! THE DRIVERS ID
        Text(driversID, style: textTheme.bodyLarge!.copyWith(fontSize: 10.0.sp))
      ]),

      //! SPACER
      const Spacer(),

      //! TRAILING
      //! COLUMN - CALL MESSAGE AND DRIVER STATUS
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(driverStatus,
            style: textTheme.bodyMedium!.copyWith(
                fontSize: 10.0.sp,
                color: driverStatus.toLowerCase().contains("transit")
                    ? AppThemeColours.appGreen
                    : driverStatus.toLowerCase().contains("duty")
                        ? AppThemeColours.appAmber
                        : AppThemeColours.appRed)),

        //! SPACER
        AppScreenUtils.verticalSpaceSmall,

        //! ICONS
        Row(children: [
          //! CALL ICON
          InkWell(
              onTap: () => AppScreenUtils.showAppCallDialogue(
                    theBuildContext: context,
                    width: 350.0.w,
                    height: 500.0.h,
                    child: CallDialogue(
                      minimize: () {},
                      maximize: () {},
                      close: () => Navigator.of(context).pop(),
                    ),
                  ),
              child: Container(
                  padding: EdgeInsets.all(10.0.sp),
                  decoration: BoxDecoration(
                      color: AppThemeColours.appBlueTransparent,
                      borderRadius: BorderRadius.circular(8.0.r)),
                  child: Icon(Icons.call,
                      size: 16.0.sp, color: AppThemeColours.appBlue))),

          //! SPACER
          AppScreenUtils.horizontalSpaceSmall,

          //! MESSAGE ICON
          InkWell(
              onTap: () {},
              child: Container(
                  padding: EdgeInsets.all(10.0.sp),
                  decoration: BoxDecoration(
                      color: AppThemeColours.appBlueTransparent,
                      borderRadius: BorderRadius.circular(8.0.r)),
                  child: Icon(Icons.message_outlined,
                      size: 16.0.sp, color: AppThemeColours.appBlue)))
        ])
      ])
    ]);
  }
}
