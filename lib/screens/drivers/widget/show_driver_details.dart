// ignore_for_file: deprecated_member_use, sdk_version_since
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urban_transit_admin/shared/utils/app_images.dart';
import 'package:urban_transit_admin/shared/utils/app_screen_utils.dart';
import 'package:urban_transit_admin/shared/utils/app_texts.dart';
import 'package:urban_transit_admin/shared/utils/profile_image.dart';
import 'package:urban_transit_admin/screens/drivers/widget/driver_information.dart';
import 'package:urban_transit_admin/screens/drivers/widget/inflow.dart';
import 'package:urban_transit_admin/screens/drivers/widget/ride_history.dart';
import 'package:urban_transit_admin/shared/utils/type_defs.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class ShowDriverDetails extends StatelessWidget {
  const ShowDriverDetails({super.key});

  @override
  Widget build(BuildContext context) {
    //! TEXT STYLE
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //! BACK ICON AND OTHERS
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //! ICON
                  InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                          padding: AppScreenUtils.containerPaddingTiny,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.8.sp,
                                  color: AppThemeColours.appBlue),
                              borderRadius: BorderRadius.circular(8.r),
                              color: AppThemeColours.appWhiteBGColour),
                          child: Row(children: [
                            Icon(Icons.arrow_back_ios,
                                size: 18.0.sp, color: AppThemeColours.appBlue),

                            //! SPACER
                            AppScreenUtils.horizontalSpaceSmall,

                            Text("All Drivers",
                                style: textTheme.bodyText1!.copyWith(
                                    height: 1.0.sp,
                                    fontSize: 16.0.sp,
                                    color: AppThemeColours.appBlue))
                          ]))),

                  //! SPACER
                  AppScreenUtils.verticalSpaceMedium,

                  //! DRIVER STATUS BOARD
                  const DriverMainDetails(),

                  //! SPACER
                  AppScreenUtils.verticalSpaceMedium,

                  //! DRIVER OTHER DETAILS BOARD
                  const DriverOtherDetails(),
                ]),

            //! SPACER
            const Spacer(),

            const DriverStatusWidget()
          ]),
    );
  }
}

//!
//!
//! DRIVER STATUS BOARD
class DriverStatusWidget extends StatelessWidget {
  const DriverStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //! TEXT STYLE
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
        padding: AppScreenUtils.containerPaddingTiny,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: const Color(0xFFE0ECFF)),

        //! CHILD
        child: Column(children: [
          //! FIRST ROW - CURRENT STATUS DETAILS
          Row(children: [
            Text("${AppTexts.currentStatus}:",
                style: textTheme.bodyText1!.copyWith(
                    fontSize: 14.0.sp, color: AppThemeColours.appBlue)),

            //! SPACER
            AppScreenUtils.horizontalSpaceSmall,

            Text(DriverStatus.enroute.name,
                style: textTheme.bodyText2!.copyWith(
                    fontSize: 14.0.sp, color: AppThemeColours.appGreen)),

            //! SPACER
            AppScreenUtils.horizontalSpaceLarge,

            //! VIEW ON MAP
            Container(
                padding: AppScreenUtils.containerPaddingTiny,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: AppThemeColours.appBlueTransparent),
                child: Row(children: [
                  Icon(Icons.route_outlined, size: 16.0.sp),

                  //! SPACER
                  AppScreenUtils.horizontalSpaceSmall,

                  //! VIEW ON MAP
                  Text(AppTexts.viewOnMap,
                      style: textTheme.bodyText2!.copyWith(
                          height: 1.0.sp,
                          fontSize: 14.0.sp,
                          color: AppThemeColours.appBlue))
                ]))
          ]),

          //! SPACER
          AppScreenUtils.verticalSpaceSmall,

          //! NUMBER OF PASSENGERS AND  MINUTES TILL ARRIVAL
          Row(children: [
            Text("24|24 Passengers",
                style: textTheme.bodyText1!
                    .copyWith(fontSize: 14.0.sp, color: Colors.grey.shade700)),

            //! SPACER
            AppScreenUtils.horizontalSpaceLarge,

            Text("15 Minutes till arrival",
                style: textTheme.bodyText2!
                    .copyWith(fontSize: 14.0.sp, color: Colors.grey.shade700))
          ]),

          //! BUS ROUTE
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Kibikibi Way -------",
                style: textTheme.bodyText2!
                    .copyWith(fontSize: 14.0.sp, color: Colors.grey.shade700)),

            //! SPACER
            AppScreenUtils.horizontalSpaceMedium,

            //! BUS ICON
            Icon(Icons.bus_alert_outlined,
                size: 16.0.sp, color: AppThemeColours.appGreen),

            //! SPACER
            AppScreenUtils.horizontalSpaceMedium,

            Text("------- Jungle Junction",
                style: textTheme.bodyText1!
                    .copyWith(fontSize: 14.0.sp, color: Colors.grey.shade700))
          ])
        ]));
  }
}

//!
//!
//! DRIVER MAIN DETAILS
class DriverMainDetails extends StatelessWidget {
  const DriverMainDetails({super.key});

  @override
  Widget build(BuildContext context) {
    //! TEXT STYLE
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
        padding: AppScreenUtils.containerPaddingSmall,
        width: 700.0.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: AppThemeColours.appWhiteBGColour),

        //! CONTENT
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          //! DRIVER DETAILS ROW - PROFILE PICTURE AND CALL ICONS
          Row(children: [
            //! PROFILE IMAGE
            const ProfilePhotoWidget(imageURL: AppImages.drivers),

            //! SPACER
            AppScreenUtils.horizontalSpaceSmall,

            //! NAME AND OTHERS
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Micheal GotDamn",
                  style: textTheme.bodyText1!.copyWith(
                      height: 1.0.sp,
                      fontSize: 16.0.sp,
                      color: AppThemeColours.appBlue)),

              //! SPACER
              AppScreenUtils.verticalSpaceSmall,

              Row(children: [
                Container(
                    height: 4.0.sp,
                    width: 4.0.sp,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppThemeColours.appGreen)),

                //! SPACER
                AppScreenUtils.horizontalSpaceSmall,

                Text("In transit",
                    style: textTheme.bodyText2!.copyWith(
                        height: 1.0.sp,
                        fontSize: 14.0.sp,
                        color: AppThemeColours.appGreen))
              ])
            ]),

            //! SPACER
            const Spacer(),

            //! ICONS
            Row(children: [
              //! CALL ICON
              InkWell(
                  onTap: () {},
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
          ]),

          //! SPACER
          AppScreenUtils.verticalSpaceMedium,

          //!
          //! OTHER PRIVATE DETAILS
          const DriverOtherPrivateDetails()
        ]));
  }
}

//!
//! DRIVER OTHER PRIVATE DETAILS
class DriverOtherPrivateDetails extends StatelessWidget {
  const DriverOtherPrivateDetails({super.key});

  @override
  Widget build(BuildContext context) {
    //! TEXT STYLE
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: 700.0.w,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        //! DRIVERS ID
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(AppTexts.driversID,
              style: textTheme.bodyText2!.copyWith(
                  height: 1.0.sp,
                  fontSize: 14.0.sp,
                  color: Colors.grey.shade700)),

          //! SPACER
          AppScreenUtils.verticalSpaceSmall,

          Text("64538252423",
              style: textTheme.bodyText1!.copyWith(
                  height: 1.0.sp,
                  fontSize: 14.0.sp,
                  color: Colors.grey.shade700))
        ]),

        //! SpACER
        AppScreenUtils.horizontalSpaceSmall,

        //! BUS
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Bus",
              style: textTheme.bodyText2!.copyWith(
                  height: 1.0.sp,
                  fontSize: 14.0.sp,
                  color: Colors.grey.shade700)),

          //! SPACER
          AppScreenUtils.verticalSpaceSmall,

          Text("Glory Bus",
              style: textTheme.bodyText1!.copyWith(
                  height: 1.0.sp,
                  fontSize: 14.0.sp,
                  color: Colors.grey.shade700))
        ]),

        //! SpACER
        AppScreenUtils.horizontalSpaceSmall,

        //! BUS SCHEDULE
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Bus Schedule",
              style: textTheme.bodyText2!.copyWith(
                  height: 1.0.sp,
                  fontSize: 14.0.sp,
                  color: Colors.grey.shade700)),

          //! SPACER
          AppScreenUtils.verticalSpaceSmall,

          Text("Mons - Weds",
              style: textTheme.bodyText1!.copyWith(
                  height: 1.0.sp,
                  fontSize: 14.0.sp,
                  color: Colors.grey.shade700))
        ]),

        //! SPACER
        AppScreenUtils.horizontalSpaceSmall,

        //! DIVIDER
        SizedBox(
            height: 20.0.sp,
            child: VerticalDivider(
                thickness: 0.8.sp, color: Colors.grey.shade400)),

        //! SPACER
        AppScreenUtils.horizontalSpaceSmall,

        //! SUSPEND
        Container(
            padding:
                EdgeInsets.symmetric(horizontal: 21.0.sp, vertical: 14.0.sp),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: AppThemeColours.appRedTransparent),

            //! CHILD
            child: Text("Suspend Driver",
                style: textTheme.bodyText2!.copyWith(
                    height: 1.0.sp,
                    fontSize: 14.0.sp,
                    color: AppThemeColours.appRed)))
      ]),
    );
  }
}

//!
//! OTHER DETAILS - DRIVER INFORMATION, INFLOW, RIDE HISTORY
class DriverOtherDetails extends StatefulWidget {
  const DriverOtherDetails({super.key});

  @override
  State<DriverOtherDetails> createState() => _DriverOtherDetailsState();
}

class _DriverOtherDetailsState extends State<DriverOtherDetails>
    with TickerProviderStateMixin {
  //! ADD DRIVER OPTIONS
  static late TabController _tabController;

  static const List<String> _addDriverOptions = [
    "Driver Information",
    "Inflow",
    "Ride History"
  ];

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    //! TEXT STYLE
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
        padding: AppScreenUtils.containerPaddingSmall,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: AppThemeColours.appWhiteBGColour),

        //! CHILD
        child: Column(children: [
          //! TABS
          SizedBox(
              height: 50.0.h,
              width: 700.0.w,
              child: //! TAB NOTIFIER
                  TabBar(
                      controller: _tabController,
                      indicatorColor: AppThemeColours.primaryColour,
                      indicatorWeight: 1.5.h,
                      physics: const BouncingScrollPhysics(),
                      onTap: (value) {},
                      tabs: _addDriverOptions
                          .map((themeOption) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(themeOption,
                                  style: textTheme.bodyText1!
                                      .copyWith(fontSize: 14.0.sp))))
                          .toList())),

          //! SPACER
          AppScreenUtils.verticalSpaceMedium,

          //!
          //! TAB BAR VIEW

          SizedBox(
              height: 500.0.h,
              width: 700.0.w,
              child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: const [
                    //! FIRST PAGE -  DRIVER INFORMATION
                    DriverInformation(),

                    //! SECOND PAGE - PAYMENT OPTIONS
                    InFlow(),

                    //! LAST PAGE - RIDE SUMMARY
                    RideHistory()
                  ]))
        ]));
  }
}
