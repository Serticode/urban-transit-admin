import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urban_transit_admin/shared/utils/app_screen_utils.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class DriverInformation extends StatelessWidget {
  const DriverInformation({super.key});

  @override
  Widget build(BuildContext context) {
    //! TEXT STYLE
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(children: [
      //! FULL NAME, DRIVER'S ID, BUS COLOUR, CURRENT ROUTE
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //!SPACER
            AppScreenUtils.verticalSpaceMedium,

            const DriverInformationWidget(
                title: "Full name", value: "Micheal GotDamn"),

            //!SPACER
            AppScreenUtils.verticalSpaceLarge,

            const DriverInformationWidget(
                title: "Driver’s ID", value: "64538252423"),

            //!SPACER
            AppScreenUtils.verticalSpaceLarge,

            const DriverInformationWidget(title: "Bus Colour", value: "Green"),

            //!SPACER
            AppScreenUtils.verticalSpaceLarge,

            const DriverInformationWidget(
                title: "Current Route", value: "From Hebron Stop"),

            //! SPACER
            const Spacer(),

            //! EDIT ROUTE BUTTON
            Container(
                padding: EdgeInsets.symmetric(
                    vertical: 12.0.sp, horizontal: 21.0.sp),
                decoration: BoxDecoration(
                    color: AppThemeColours.appGreenTransparent,
                    borderRadius: BorderRadius.circular(5.0.r)),
                child: Row(children: [
                  //! ICON
                  Icon(Icons.route_outlined,
                      color: AppThemeColours.appGreen, size: 16.0.sp),

                  //! SPACER
                  AppScreenUtils.horizontalSpaceSmall,

                  Text("Edit Route",
                      style: textTheme.bodyLarge!.copyWith(
                          height: 1.0.sp,
                          color: AppThemeColours.appGreen,
                          fontSize: 14.0.sp))
                ]))
          ]),

      //!SPACER
      const Spacer(),

      //! SEX, PHONE NUMBER, NO OF SEATS, DRIVER'S STATUS
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //!SPACER
            AppScreenUtils.verticalSpaceMedium,

            const DriverInformationWidget(title: "Sex", value: "Male"),

            //!SPACER
            AppScreenUtils.verticalSpaceLarge,

            const DriverInformationWidget(
                title: "Phone Number", value: "080345678696"),

            //!SPACER
            AppScreenUtils.verticalSpaceLarge,

            const DriverInformationWidget(title: "No of Seats", value: "24"),

            //!SPACER
            AppScreenUtils.verticalSpaceLarge,

            const DriverInformationWidget(
                title: "Driver’s Status", value: "Active Driver")
          ]),

      //!SPACER
      const Spacer(),

      //! DATE OF BIRTH, EMAIL ADDRESS, BUS NUMBER
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //!SPACER
            AppScreenUtils.verticalSpaceMedium,

            const DriverInformationWidget(
                title: "Date of Birth", value: "17/08/1999"),

            //!SPACER
            AppScreenUtils.verticalSpaceLarge,

            const DriverInformationWidget(
                title: "Email Address", value: "michy1@gmail.com"),

            //!SPACER
            AppScreenUtils.verticalSpaceLarge,

            const DriverInformationWidget(
                title: "Bus Number", value: "Ak76854J"),

            //! SPACER
            const Spacer(),

            //! EDIT INFORMATION BUTTON
            Container(
                padding: EdgeInsets.symmetric(
                    vertical: 12.0.sp, horizontal: 21.0.sp),
                decoration: BoxDecoration(
                    color: AppThemeColours.appBlueTransparent,
                    borderRadius: BorderRadius.circular(5.0.r)),
                child: Row(children: [
                  //! ICON
                  Icon(Icons.edit_outlined,
                      color: AppThemeColours.appBlue, size: 16.0.sp),

                  //! SPACER
                  AppScreenUtils.horizontalSpaceSmall,

                  Text("Edit Information",
                      style: textTheme.bodyLarge!.copyWith(
                          height: 1.0.sp,
                          color: AppThemeColours.appBlue,
                          fontSize: 14.0.sp))
                ]))
          ])
    ]);
  }
}

class DriverInformationWidget extends StatelessWidget {
  final String title;
  final String value;
  const DriverInformationWidget(
      {super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    //! TEXT STYLE
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      //! TITLE
      Text(title, style: textTheme.displayLarge!.copyWith(fontSize: 16.0.sp)),

      //! SPACER
      AppScreenUtils.verticalSpaceSmall,

      //! VALUE
      Text(value, style: textTheme.bodyMedium!.copyWith(fontSize: 12.0.sp))
    ]);
  }
}
