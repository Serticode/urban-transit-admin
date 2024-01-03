import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urban_transit_admin/shared/utils/app_fade_animation.dart';
import 'package:urban_transit_admin/shared/utils/app_images.dart';
import 'package:urban_transit_admin/shared/utils/app_screen_utils.dart';
import 'package:urban_transit_admin/shared/utils/app_texts.dart';
import 'package:urban_transit_admin/shared/utils/constants.dart';
import 'package:urban_transit_admin/shared/utils/profile_image.dart';
import 'package:urban_transit_admin/screens/widgets/call_dialogue.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class DashboardDrivers extends StatefulWidget {
  final void Function() minimize;
  final void Function() maximize;
  final void Function() close;
  final double? height;
  const DashboardDrivers({
    super.key,
    required this.minimize,
    required this.maximize,
    required this.close,
    this.height,
  });

  @override
  State<DashboardDrivers> createState() => _DashboardDriversState();
}

class _DashboardDriversState extends State<DashboardDrivers> {
  //! DEFINITIONS
  static const List<String> driverNames = [
    "Micheal GotDamn",
    "Ire Okigidi",
    "Kingsley Mostavvan",
    "Nick Foxword",
    "William Oyedapo"
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
                ...AppConstants.menuIcons.map((icon) => Padding(
                    padding: EdgeInsets.only(right: 6.0.sp),
                    child: InkWell(
                        onTap: () => menuIconOnTapTrigger(
                            index: AppConstants.menuIcons.indexOf(icon)),
                        child: CircleAvatar(
                            radius: 14.0.r,
                            backgroundColor: AppConstants.menuIconBGColour
                                .elementAt(
                                    AppConstants.menuIcons.indexOf(icon)),
                            child: Icon(icon,
                                size: 12.0.sp,
                                color: AppConstants.menuIconColours.elementAt(
                                    AppConstants.menuIcons.indexOf(icon)))))))
              ]))
          :

          //! IS VISIBLE
          Column(
              children: [
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
                      ...AppConstants.menuIcons.map((icon) => Padding(
                          padding: EdgeInsets.only(right: 6.0.sp),
                          child: InkWell(
                              onTap: () => menuIconOnTapTrigger(
                                  index: AppConstants.menuIcons.indexOf(icon)),
                              child: CircleAvatar(
                                  radius: 14.0.r,
                                  backgroundColor: AppConstants.menuIconBGColour
                                      .elementAt(
                                          AppConstants.menuIcons.indexOf(icon)),
                                  child: Icon(icon,
                                      size: 12.0.sp,
                                      color: AppConstants.menuIconColours
                                          .elementAt(AppConstants.menuIcons
                                              .indexOf(icon)))))))
                    ])),

                //! SPACER
                AppScreenUtils.verticalSpaceMedium,

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: driverNames
                          .map(
                            (name) => Padding(
                              padding: EdgeInsets.only(bottom: 21.0.h),
                              child: DriversTile(
                                fullName: name,
                                contact: "#64538252423",
                                index: driverNames.indexOf(name),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                )
              ],
            ),
    );
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
//! DRIVERS CONTENT / TILE
class DriversTile extends StatelessWidget {
  final String fullName;
  final String contact;
  final int index;
  const DriversTile({
    super.key,
    required this.fullName,
    required this.contact,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    //! TEXT STYLE
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        ProfilePhotoWidget(
          imageURL: index.isEven
              ? AppImages.user2
              : index / 3 == 0
                  ? AppImages.user3
                  : AppImages.user1,
        ),

        //! SPACER
        AppScreenUtils.horizontalSpaceSmall,

        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(fullName,
              style: textTheme.bodyLarge!.copyWith(fontSize: 14.0.sp)),

          //! CONTACT / IS ONLINE
          Text(contact,
              style: textTheme.bodyMedium!.copyWith(fontSize: 12.0.sp))
        ]),

        //! SPACER
        const Spacer(),

        //! TRAILING
        Row(
          children: [
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
                  borderRadius: BorderRadius.circular(8.0.r),
                ),
                child: Icon(
                  Icons.call,
                  size: 16.0.sp,
                  color: AppThemeColours.appBlue,
                ),
              ),
            ),

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
                    size: 16.0.sp, color: AppThemeColours.appBlue),
              ),
            )
          ],
        )
      ],
    );
  }
}
