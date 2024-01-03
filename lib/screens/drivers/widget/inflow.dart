import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urban_transit_admin/shared/utils/app_screen_utils.dart';
import 'package:urban_transit_admin/screens/drivers/widget/bar_chart.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class InFlow extends StatelessWidget {
  const InFlow({super.key});

  static const List<IconData> _icons = [
    Icons.wallet_outlined,
    Icons.local_atm,
    Icons.credit_card
  ];

  static const List<String> _iconValues = [
    "2 Wallet Trips",
    "10 Cash Trips",
    "18 Card Trips"
  ];

  @override
  Widget build(BuildContext context) {
    //! TEXT STYLE
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(children: [
      //! HEADER
      Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(children: [
              //! DATE
              Text("Today’s Inflow",
                  style: textTheme.bodyMedium!.copyWith(
                      color: AppThemeColours.appGreen, fontSize: 24.0.sp)),

              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("₦50,000",
                        style: textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w800, fontSize: 21.0.sp)),

                    //! SPACER
                    AppScreenUtils.horizontalSpaceSmall,

                    Container(
                        padding: EdgeInsets.all(5.0.sp),
                        decoration: BoxDecoration(
                            color: AppThemeColours.appGreenTransparent,
                            borderRadius: BorderRadius.circular(12.0.r)),
                        child: Text("+500",
                            style: textTheme.bodyMedium!.copyWith(
                                color: AppThemeColours.appGreen,
                                fontWeight: FontWeight.w600,
                                fontSize: 12.0.sp)))
                  ])
            ]),

            //! SPACER
            const Spacer(),

            //! DATE AND NUMBER OF PASSENGERS
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //! DATE
                  Text(AppScreenUtils.getTodaysDate(),
                      style: textTheme.bodyMedium!.copyWith(
                          color: Colors.grey.shade400, fontSize: 10.0.sp)),

                  //! SPACER
                  AppScreenUtils.verticalSpaceSmall,

                  //! NUMBER OF PASSENGERS
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("30",
                            style: textTheme.bodyMedium!.copyWith(
                                color: AppThemeColours.appGreen,
                                fontWeight: FontWeight.w600,
                                fontSize: 12.0.sp)),

                        //! SPACER
                        AppScreenUtils.horizontalSpaceSmall,

                        Text("passengers so far",
                            style: textTheme.bodyMedium!.copyWith(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w600,
                                fontSize: 12.0.sp))
                      ])
                ])
          ]),

      //! SPACER
      AppScreenUtils.verticalSpaceSmall,

      //! ICONS
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
              _icons.length,
              (index) => IconsWidget(
                  theIcon: _icons.elementAt(index),
                  theTag: _iconValues.elementAt(index)))),

      //! SPACER
      AppScreenUtils.verticalSpaceLarge,

      //! THE GRAPH
      const DriverInflowGraph()
    ]);
  }
}

//! ICONS WIDGETS
class IconsWidget extends StatelessWidget {
  final bool? isTransformed;
  final IconData theIcon;
  final String theTag;
  const IconsWidget(
      {super.key,
      this.isTransformed,
      required this.theIcon,
      required this.theTag});

  @override
  Widget build(BuildContext context) {
    //! TEXT STYLE
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(children: [
      //! ICON
      Container(
          padding: EdgeInsets.all(8.0.sp),
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppThemeColours.appGreenTransparent),
          child: Icon(theIcon, size: 16.0.sp, color: AppThemeColours.appGreen)),

      //! SPACER
      AppScreenUtils.horizontalSpaceSmall,

      //! TEXT
      Text(theTag, style: textTheme.bodyMedium!.copyWith(fontSize: 12.0.sp))
    ]);
  }
}

//! DRIVER INFLOW GRAPH
class DriverInflowGraph extends StatelessWidget {
  const DriverInflowGraph({super.key});

  @override
  Widget build(BuildContext context) {
    //! TEXT STYLE
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(children: [
      //! HEADER
      Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("₦50,000",
                style: textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w800,
                    color: Colors.grey.shade600,
                    height: 1.0.sp,
                    fontSize: 18.0.sp)),

            //! SPACER
            AppScreenUtils.horizontalSpaceSmall,

            Text("30",
                style: textTheme.bodyMedium!.copyWith(
                    color: AppThemeColours.appGreen,
                    fontWeight: FontWeight.w600,
                    height: 1.0.sp,
                    fontSize: 12.0.sp)),

            //! SPACER
            AppScreenUtils.horizontalSpaceSmall,

            Text("passengers.",
                style: textTheme.bodyMedium!.copyWith(
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w600,
                    height: 1.0.sp,
                    fontSize: 1.0.sp)),

            //! SPACER
            const Spacer(),

            //! FILTER
            CircleAvatar(
                radius: 18.0.r,
                backgroundColor: AppThemeColours.appGreenTransparent,
                child: CircleAvatar(
                    radius: 12.0.r,
                    backgroundColor: AppThemeColours.appGreen,
                    child: Icon(Icons.filter_list,
                        size: 16.0.sp,
                        color: AppThemeColours.appWhiteBGColour)))
          ]),

      //! SPACER
      AppScreenUtils.verticalSpaceMedium,

      //! GRAPH
      const AppBarChart()
    ]);
  }
}
