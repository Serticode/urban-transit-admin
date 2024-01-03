//! DRIVERS INFLOW
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urban_transit_admin/shared/utils/app_images.dart';
import 'package:urban_transit_admin/shared/utils/app_screen_utils.dart';
import 'package:urban_transit_admin/shared/utils/profile_image.dart';
import 'package:urban_transit_admin/screens/widgets/app_text_form_field.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class DriversInflow extends StatelessWidget {
  DriversInflow({super.key});
  final TextEditingController _fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //! TEXT STYLE
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
        width: 430.0.w,
        height: 520.0.h,
        margin: EdgeInsets.symmetric(horizontal: 12.0.w),
        decoration: BoxDecoration(
            color: AppThemeColours.appWhiteBGColour,
            borderRadius: BorderRadius.circular(8.0.r),
            boxShadow: <BoxShadow>[
              BoxShadow(blurRadius: 12.0.r, color: Colors.grey.shade200)
            ]),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //! TITLE
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 18.0.h),
                child: Text(
                  "Drivers Inflow",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 18.0.sp,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),

              //! DIVIDER
              Divider(
                thickness: 2.0.h,
                height: 2.0.h,
                color: AppThemeColours.backgroundColourGrey,
              ),

              //! FULL NAME TEXT FIELD
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 24.0.w, vertical: 14.0.h),
                  child: AppTextFormField(
                      controller: _fullNameController,
                      padding: EdgeInsets.symmetric(
                          vertical: 6.0.h, horizontal: 21.0.w),
                      prefixIcon: Transform.scale(
                          scale: 0.7,
                          child: const CircleAvatar(
                              backgroundColor:
                                  AppThemeColours.appBlueTransparent,
                              child: Icon(Icons.search,
                                  color: AppThemeColours.black))),
                      hintText: "Search")),

              //! SPACER
              AppScreenUtils.verticalSpaceSmall,

              //! TODAYS DATE
              Center(
                  child: Text(AppScreenUtils.getTodaysDate(),
                      style: textTheme.displayMedium!.copyWith(
                          color: Colors.grey.shade600, fontSize: 14.0.sp))),

              //! SPACER
              AppScreenUtils.verticalSpaceSmall,

              //! DETAILS;/
              Expanded(
                  child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                          children: List.generate(
                              8,
                              (index) => Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 24.0.w, vertical: 12.0.h),
                                  child: DriversInflowWidget(index: index))))))
            ]));
  }
}

//! DRIVERS INFLOW WIDGET
class DriversInflowWidget extends StatelessWidget {
  final int index;
  const DriversInflowWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final TextStyle textTheme = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(fontSize: 16.0.sp, fontWeight: FontWeight.w400);

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      ProfilePhotoWidget(
        imageURL: index.isEven
            ? AppImages.user2
            : index / 3 == 0
                ? AppImages.user3
                : AppImages.user1,
      ),

      //! SPACER
      AppScreenUtils.horizontalSpaceSmall,

      //! NAME
      Text("Timmy Tunde",
          style: textTheme.copyWith(
              color: AppThemeColours.black,
              fontSize: 16.0.sp,
              fontWeight: FontWeight.w500)),

      //! SPACER
      const Spacer(),

      //! PRICE TAG
      Container(
          padding: EdgeInsets.symmetric(vertical: 6.0.h, horizontal: 12.0.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0.r),
              color: const Color(0xFFAECCFF)),
          child: Center(
              child: Text("₦50,000",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 14.0.sp,
                      fontWeight: FontWeight.w700,
                      color: AppThemeColours.appBlue))))
    ]);
  }
}
