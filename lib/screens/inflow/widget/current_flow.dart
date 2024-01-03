//! CURRENT FLOW
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urban_transit_admin/shared/utils/app_images.dart';
import 'package:urban_transit_admin/shared/utils/app_screen_utils.dart';
import 'package:urban_transit_admin/shared/utils/profile_image.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class CurrentFlow extends StatelessWidget {
  const CurrentFlow({super.key});

  @override
  Widget build(BuildContext context) => Container(
        width: 710.0.w,
        height: 520.0.h,
        decoration: BoxDecoration(
          color: AppThemeColours.appWhiteBGColour,
          borderRadius: BorderRadius.circular(8.0.r),
          boxShadow: <BoxShadow>[
            BoxShadow(blurRadius: 12.0.r, color: Colors.grey.shade200)
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //! TITLE
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 18.0.h),
              child: Text(
                "Current Inflow",
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

            //! SPACER
            AppScreenUtils.verticalSpaceSmall,

            //! DETAILS
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(
                    8,
                    (index) => Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.0.w, vertical: 12.0.h),
                      child: CurrentFlowWidget(
                        index: index,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

//! CURRENT INFLOW WIDGET
class CurrentFlowWidget extends StatelessWidget {
  final int index;
  const CurrentFlowWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final TextStyle textTheme = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(fontSize: 16.0.sp, fontWeight: FontWeight.w400);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //! NAME, TIME, TRIP TYPE
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //! NAME
            Text("User $index",
                style: textTheme.copyWith(fontWeight: FontWeight.w600)),

            //! SPACER
            AppScreenUtils.verticalSpaceSmall,

            //! TIME & TRIP
            Row(
              children: [
                //! TIME
                Text("12:39pm", style: textTheme.copyWith(fontSize: 12.0.sp)),

                //! SPACER
                AppScreenUtils.horizontalSpaceSmall,

                //! TRIP TYPE
                Text("Cash Trip",
                    style: textTheme.copyWith(
                        fontSize: 12.0.sp, color: AppThemeColours.appGreen))
              ],
            )
          ],
        ),

        //! SPACER
        AppScreenUtils.horizontalSpaceMedium,

        //! PRICE TAG
        Container(
          padding: EdgeInsets.symmetric(vertical: 6.0.h, horizontal: 12.0.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0.r),
              color: const Color(0xFFAECCFF)),
          child: Center(
            child: Text(
              "₦500",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 14.0.sp,
                    fontWeight: FontWeight.w700,
                    color: AppThemeColours.appBlue,
                  ),
            ),
          ),
        ),

        //! SPACER
        AppScreenUtils.horizontalSpaceMedium,

        //! TRIP STORY & DRIVER NAME
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Row(
            children: [
              //! TRIP LOCATION
              Icon(Icons.location_on,
                  size: 16.0.sp, color: AppThemeColours.appGreen),

              //! SPACER
              AppScreenUtils.horizontalSpaceSmall,

              //! LOCATION DETAILS
              Text("Freedom Stop",
                  style: textTheme.copyWith(
                      color: Colors.grey.shade400, fontSize: 12.0.sp)),

              //! SPACER
              AppScreenUtils.horizontalSpaceSmall,

              //! LOCATION DETAILS
              Text("---- Hospital way",
                  style: textTheme.copyWith(
                      color: AppThemeColours.appGreen, fontSize: 12.0.sp))
            ],
          ),

          //! SPACER
          AppScreenUtils.verticalSpaceSmall,

          //! DRIVER DETAIL
          Row(children: [
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
            Text("Micheal GotDamn",
                style: textTheme.copyWith(
                    color: AppThemeColours.black, fontSize: 12.0.sp))
          ])
        ])
      ],
    );
  }
}
