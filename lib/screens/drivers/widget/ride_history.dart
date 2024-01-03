// ignore_for_file: sdk_version_since

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urban_transit_admin/shared/utils/app_screen_utils.dart';
import 'package:urban_transit_admin/shared/utils/type_defs.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class RideHistory extends StatelessWidget {
  const RideHistory({super.key});

  @override
  Widget build(BuildContext context) {
    //! TEXT STYLE
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      //! TODAYS DATE
      Text(AppScreenUtils.getTodaysDate(),
          style: textTheme.displayLarge!
              .copyWith(color: Colors.grey.shade600, fontSize: 18.0.sp)),

      //! SPACER
      AppScreenUtils.verticalSpaceMedium,

      //! ROW - NUMBER OF PASSENGERS AND OTHERS
      Row(children: [
        //! NUMBER OF PASSENGERS
        Container(
            padding: EdgeInsets.all(12.0.sp),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0.r),
                color: AppThemeColours.appGreenTransparent),
            child: Text("30",
                style: textTheme.displayLarge!.copyWith(
                    color: AppThemeColours.appGreen, fontSize: 14.0.sp))),

        //! SPACER
        AppScreenUtils.horizontalSpaceSmall,

        Text("Passengers so far.",
            style: textTheme.bodyMedium!
                .copyWith(color: Colors.grey.shade600, fontSize: 12.0.sp)),

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

      //! LIST OF DRIVER TRIPS
      Expanded(
          child: SingleChildScrollView(
              child: Column(
                  children: List.generate(
                      10,
                      (index) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0.h),
                          child: DriverTripsWidget(
                              passengerName: "Amarachi **e $index",
                              paymentType: index.isEven
                                  ? TripPaymentType.cash
                                  : TripPaymentType.wallet))))))
    ]);
  }
}

class DriverTripsWidget extends StatelessWidget {
  final String passengerName;
  final TripPaymentType paymentType;
  const DriverTripsWidget(
      {super.key, required this.passengerName, required this.paymentType});

  @override
  Widget build(BuildContext context) {
    //! TEXT STYLE
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(children: [
      //! NAME, TIME AND TRIP TYPE
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //! NAME
        Text(passengerName,
            style: textTheme.bodyLarge!
                .copyWith(height: 1.0.sp, fontSize: 14.0.sp)),

        //! SPACER
        AppScreenUtils.verticalSpaceSmall,

        //! PAYMENT TYPE AND TIME
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Text("12:39pm",
              style: textTheme.bodyLarge!
                  .copyWith(height: 1.0.sp, fontSize: 10.0.sp)),

          //! SPACER
          AppScreenUtils.horizontalSpaceSmall,

          Text(paymentType.name,
              style: textTheme.bodyLarge!.copyWith(
                  height: 1.0.sp,
                  color: AppThemeColours.appGreen,
                  fontSize: 10.0.sp))
        ])
      ]),

      //! SPACER
      const Spacer(),

      //! PRICE
      Container(
          padding: EdgeInsets.all(8.0.sp),
          decoration: BoxDecoration(
              color: AppThemeColours.appBlueTransparent,
              borderRadius: BorderRadius.circular(5.0.r)),
          child: Text("#500",
              style: textTheme.displayLarge!.copyWith(
                  height: 1.0.sp,
                  color: AppThemeColours.appBlue,
                  fontSize: 14.0.sp))),

      //! SPACER
      const Spacer(),

      //! TRIP LOCATION
      Icon(Icons.location_on, size: 16.0.sp, color: AppThemeColours.appGreen),

      //! SPACER
      AppScreenUtils.horizontalSpaceSmall,

      //! LOCATION DETAILS
      Text("Freedom Stop",
          style: textTheme.bodyMedium!
              .copyWith(color: Colors.grey.shade400, fontSize: 12.0.sp)),

      //! SPACER
      AppScreenUtils.horizontalSpaceSmall,

      //! LOCATION DETAILS
      Text("---- Hospital way",
          style: textTheme.bodyMedium!
              .copyWith(color: AppThemeColours.appGreen, fontSize: 12.0.sp))
    ]);
  }
}
