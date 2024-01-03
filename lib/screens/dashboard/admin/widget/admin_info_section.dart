//!
//! ADMIN INFORMATION
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urban_transit_admin/shared/utils/app_extensions.dart';
import 'package:urban_transit_admin/shared/utils/app_screen_utils.dart';
import 'package:urban_transit_admin/shared/utils/app_texts.dart';
import 'package:urban_transit_admin/screens/widgets/app_text_form_field.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class AdminInformationSection extends ConsumerStatefulWidget {
  const AdminInformationSection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminInformationSectionState();
}

class _AdminInformationSectionState
    extends ConsumerState<AdminInformationSection> {
  final TextEditingController _adminEmailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _organizationNameTextController =
      TextEditingController();
  final TextEditingController _organizationTypeTextController =
      TextEditingController();

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
            AppTexts.adminInformation,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 21.0.sp,
                  fontWeight: FontWeight.w600,
                ),
          ),

          //! SPACER
          21.0.sizedBoxHeight,

          //! IMAGE
          Row(children: [
            Container(
              height: 120.0.h,
              width: 95.0.w,
              decoration: BoxDecoration(
                color: AppThemeColours.appBlueTransparent.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8.0.r),
                image: const DecorationImage(
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.contain,
                    image: AssetImage("lib/assets/images/nile_uni_logo.png")),
                border: Border.all(color: AppThemeColours.appBlue),
              ),
            ),

            //! SPACER
            AppScreenUtils.horizontalSpaceSmall,

            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //! PROFILE PHOTO
              Text(AppTexts.profilePhoto,
                  style: textTheme.bodyLarge!.copyWith(
                      color: AppThemeColours.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0.sp)),

              //! SPACER
              AppScreenUtils.verticalSpaceSmall,

              //! CHANGE PROFILE PHOTO
              Text(AppTexts.changeProfilePhoto,
                  style: textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0.sp,
                      color: AppThemeColours.appGreen))
            ])
          ]),

          32.0.sizedBoxHeight,

          //! ADMIN EMAIL
          Text(AppTexts.adminEmail,
              style: textTheme.bodyLarge!.copyWith(fontSize: 14.0.sp)),

          //! SPACER
          AppScreenUtils.verticalSpaceSmall,

          //! ADMIN EMAIL TEXT FIELD
          AppTextFormField(
              controller: _adminEmailController,
              hintText: "nileuniversityadmin@staff.edu.ng"),

          //! SPACER
          AppScreenUtils.verticalSpaceMedium,

          //! USERNAME
          Text(AppTexts.userName,
              style: textTheme.bodyLarge!.copyWith(fontSize: 14.0.sp)),

          //! SPACER
          AppScreenUtils.verticalSpaceSmall,

          //! USER NAME TEXT FIELD
          AppTextFormField(
              controller: _userNameController, hintText: "Nile Admin"),

          //! SPACER
          AppScreenUtils.verticalSpaceMedium,

          //! ORGANIZATION NAME
          Text(AppTexts.organizationName,
              style: textTheme.bodyLarge!.copyWith(fontSize: 14.0.sp)),

          //! SPACER
          AppScreenUtils.verticalSpaceSmall,

          //! ORGANIZATION NAME TEXT FIELD
          AppTextFormField(
              controller: _organizationNameTextController,
              hintText: "Nile University"),

          //! SPACER
          AppScreenUtils.verticalSpaceMedium,

          //! ORGANIZATION TYPE
          Text(AppTexts.organizationType,
              style: textTheme.bodyLarge!.copyWith(fontSize: 14.0.sp)),

          //! SPACER
          AppScreenUtils.verticalSpaceSmall,

          //! ORGANIZATION TYPE TEXT FIELD
          AppTextFormField(
              controller: _organizationTypeTextController, hintText: "School"),

          //! SPACER
          AppScreenUtils.verticalSpaceLarge,

          //! EDIT INFORMATION BUTTON
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 180.0.w,
              padding:
                  EdgeInsets.symmetric(vertical: 12.0.sp, horizontal: 21.0.sp),
              decoration: BoxDecoration(
                color: AppThemeColours.appBlueTransparent,
                borderRadius: BorderRadius.circular(5.0.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //! ICON
                  Icon(Icons.edit_outlined,
                      color: AppThemeColours.appBlue, size: 16.0.sp),

                  //! SPACER
                  AppScreenUtils.horizontalSpaceSmall,

                  Text(
                    "Edit Information",
                    style: textTheme.bodyLarge!.copyWith(
                      height: 1.0.sp,
                      color: AppThemeColours.appBlue,
                      fontSize: 14.0.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
