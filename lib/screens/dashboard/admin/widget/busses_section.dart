import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:urban_transit_admin/shared/utils/app_divider.dart';
import 'package:urban_transit_admin/shared/utils/app_extensions.dart';
import 'package:urban_transit_admin/shared/utils/app_screen_utils.dart';
import 'package:urban_transit_admin/shared/utils/app_texts.dart';
import 'package:urban_transit_admin/screens/widgets/app_text_form_field.dart';
import 'package:urban_transit_admin/screens/drivers/widget/add_driver.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class BussesSection extends ConsumerStatefulWidget {
  const BussesSection({super.key});

  @override
  ConsumerState<BussesSection> createState() => _BussesSectionState();
}

class _BussesSectionState extends ConsumerState<BussesSection> {
  final TextEditingController _fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: AppScreenUtils.containerPadding,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0.r),
          boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: 6.0.r,
              spreadRadius: 12.0.r,
              color: Colors.grey.shade200.withOpacity(0.5),
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //! TITLE
          Text(
            AppTexts.buses,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 21.0.sp,
                  fontWeight: FontWeight.w600,
                ),
          ),

          //! SPACER
          21.0.sizedBoxHeight,

          //! CONTENT - NUMBER OF ACTIVE DRIVERS
          //! TITLE
          Text(
            "10 ${AppTexts.buses}",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 16.0.sp,
                  fontWeight: FontWeight.w600,
                ),
          ),

          //! SPACER
          AppScreenUtils.verticalSpaceSmall,

          //! NUMBER OF ACTIVE OFF DUTY AND SUSPENDED
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(
              "8 Currently in transit,",
              style: textTheme.bodyMedium!.copyWith(
                fontSize: 14.0.sp,
                color: AppThemeColours.appGreen,
              ),
            ),

            //! SPACER
            AppScreenUtils.horizontalSpaceSmall,

            Text(
              "2 Off Duty",
              style: textTheme.bodyMedium!.copyWith(
                fontSize: 14.0.sp,
                color: AppThemeColours.appAmber,
              ),
            )
          ]),

          //! SPACER
          AppScreenUtils.verticalSpaceSmall,

          Row(
            children: [
              //! ADD BUTTON
              InkWell(
                  //! ADD DRIVER
                  onTap: () => AppScreenUtils.showAppDialogBox(
                        theBuildContext: context,
                        width: 832.0.w,
                        height: 910.h,
                        child: const AddDriver(),
                      ),

                  //! OTHERS
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0.sp, horizontal: 21.0.sp),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0.r),
                          border: Border.all(
                              width: 0.8, color: AppThemeColours.appGreen)),
                      child: Row(children: [
                        //! ICON
                        const Icon(Icons.add,
                            size: 14.0, color: AppThemeColours.appGreen),

                        //! SPACER
                        AppScreenUtils.horizontalSpaceSmall,

                        //! TEXT
                        Text(
                          "Add New Bus",
                          style: textTheme.bodyMedium!.copyWith(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                            color: AppThemeColours.appGreen,
                          ),
                        )
                      ]))),

              //! SPACER
              AppScreenUtils.horizontalSpaceMedium,

              Expanded(
                child: //! FULL NAME TEXT FIELD
                    Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 0.0.w, vertical: 14.0.h),
                  child: AppTextFormField(
                    controller: _fullNameController,
                    padding: EdgeInsets.symmetric(
                        vertical: 6.0.h, horizontal: 21.0.w),
                    prefixIcon: Transform.scale(
                      scale: 0.7,
                      child: const CircleAvatar(
                        backgroundColor: AppThemeColours.appBlueTransparent,
                        child: Icon(
                          Icons.search,
                          color: AppThemeColours.black,
                        ),
                      ),
                    ),
                    hintText: "Search",
                  ),
                ),
              ),
            ],
          ),

          //! SPACER
          AppScreenUtils.verticalSpaceSmall,

          Expanded(
            child: ListView.separated(
              itemCount: 4,
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) => const AppDivider(),
              itemBuilder: (context, index) => ListOfBusesWidget(index: index),
            ),
          )
        ],
      ),
    );
  }
}

//! LIST OF BUSES WIDGET
class ListOfBusesWidget extends ConsumerWidget {
  final int index;
  const ListOfBusesWidget({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextStyle textTheme = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(fontSize: 16.0.sp, fontWeight: FontWeight.w400);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0.h),
      child: Row(children: [
        //!  BUS IMAGE
        Transform.scale(
          scale: 0.5,
          child: (index == 2 || index == 3)
              ? SvgPicture.asset("lib/assets/icons/yellowBus.svg")
              : (index == 5 || index == 6)
                  ? SvgPicture.asset("lib/assets/icons/greyBus.svg")
                  : SvgPicture.asset("lib/assets/icons/greenBus.svg"),
        ),

        //! SPACER
        AppScreenUtils.horizontalSpaceSmall,

        //! NAME & NUMBER
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //! NAME
          Text(
            "Glory Bus",
            style: textTheme.copyWith(
              color: AppThemeColours.black,
              fontWeight: FontWeight.w500,
              fontSize: 18.0,
            ),
          ),

          //! SPACER
          AppScreenUtils.verticalSpaceSmall,

          //! NUMBER
          Text(
            "Bus Number \nAK76854J",
            style: textTheme.copyWith(
              color: AppThemeColours.black,
              fontWeight: FontWeight.w400,
              fontSize: 12.0,
            ),
          )
        ]),

        //! SPACER
        const Spacer(),

        //! TRANSIT / OFF DUTY
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          //! IN TRANSIT
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
                height: 8.0.sp,
                width: 8.0.sp,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppThemeColours.appGreen)),

            //! SPACER
            AppScreenUtils.horizontalSpaceSmall,

            Text("In transit",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    height: 1.0.sp,
                    fontSize: 14.0.sp,
                    color: AppThemeColours.appGreen))
          ]),

          //! SPACER
          AppScreenUtils.verticalSpaceSmall,

          //! CURRENT LOCATION
          Text("Current Location",
              style: textTheme.copyWith(
                  color: AppThemeColours.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.0.sp)),

          //! SPACER
          AppScreenUtils.verticalSpaceSmall,

          //! FREEDOM STOP
          Row(children: [
            //! TRIP LOCATION
            Icon(Icons.location_on,
                size: 16.0.sp, color: AppThemeColours.appGreen),

            //! SPACER
            AppScreenUtils.horizontalSpaceSmall,

            //! LOCATION DETAILS
            Text("Freedom Stop",
                style: textTheme.copyWith(
                    color: AppThemeColours.appGreen,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0.sp))
          ])
        ])
      ]),
    );
  }
}
