import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:urban_transit_admin/router/router.dart';
import 'package:urban_transit_admin/router/routes.dart';
import 'package:urban_transit_admin/screens/auth/basic_setup/widget/organization_type_selector.dart';
import 'package:urban_transit_admin/screens/auth/basic_setup/widget/shimmer.dart';
import 'package:urban_transit_admin/screens/widgets/app_elevated_button.dart';
import 'package:urban_transit_admin/screens/widgets/app_text_form_field.dart';
import 'package:urban_transit_admin/shared/utils/app_extensions.dart';
import 'package:urban_transit_admin/shared/utils/app_images.dart';
import 'package:urban_transit_admin/shared/utils/app_screen_utils.dart';
import 'package:urban_transit_admin/shared/utils/app_texts.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class BasicSetup extends ConsumerWidget {
  const BasicSetup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final organizationsNameController = TextEditingController();

    return Scaffold(
      body: Stack(
        children: [
          const BasicSetupShimmer(),

          //!
          Material(
            elevation: 40.0,
            shadowColor: Colors.black26,
            color: Colors.transparent,
            child: Container(
              height: 850.0.h,
              width: 745.0.w,
              padding: AppScreenUtils.containerPadding,
              color: AppThemeColours.appWhiteBGColour,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTexts.basicSetup.txt(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w800,
                  ),

                  12.0.sizedBoxHeight,

                  AppTexts.basicSetupRider.txt(
                      fontSize: 20.0.sp,
                      fontWeight: FontWeight.w400,
                      color: AppThemeColours.bodyText2TextColour),

                  42.0.sizedBoxHeight,

                  AppTexts.yourOrganizationName.txt(
                    fontSize: 18.0.sp,
                    fontWeight: FontWeight.w500,
                  ),

                  6.0.sizedBoxHeight,

                  AppTextFormField(
                    hintText: AppTexts.yourOrganizationName,
                    controller: organizationsNameController,
                    onChanged: (textContent) {},
                  ),

                  42.0.sizedBoxHeight,

                  AppTexts.yourOrganizationType.txt(
                    fontSize: 18.0.sp,
                    fontWeight: FontWeight.w500,
                  ),

                  6.0.sizedBoxHeight,

                  const OrganizationTypeSelector(),

                  42.0.sizedBoxHeight,

                  AppTexts.uploadProfileImage.txt(
                    fontSize: 18.0.sp,
                    fontWeight: FontWeight.w500,
                  ),

                  21.0.sizedBoxHeight,

                  Container(
                    width: 459.0.w,
                    height: 181.0.h,
                    decoration: BoxDecoration(
                      color: AppThemeColours.appGreyBGColour.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5.0.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //! ICON
                        SvgPicture.asset(AppSVG.uploadImage),

                        AppTexts.uploadFileNotice.txt(
                          fontSize: 14.0.sp,
                          color: AppThemeColours.bodyText2TextColour,
                        ),
                      ],
                    ),
                  ).alignCenter(),

                  const Spacer(),

                  //!
                  Row(
                    children: [
                      AppElevatedButton(
                        buttonTitle: AppTexts.saveAndGoToDashboard,
                        //!TODO:
                        onPressed: () =>
                            AppNavigator.navigateToAndRemoveAllPreviousScreens(
                          thePageRouteName: AppRoutes.dashboardWrapper,
                          context: context,
                        ),
                      ),

                      //!
                      Expanded(
                        child: "Skip"
                            .txt(
                              fontSize: 20.0.sp,
                              fontWeight: FontWeight.w500,
                              color: AppThemeColours.appBlue,
                            )
                            .alignCenter()
                            .onTap(
                              onTap: () => AppNavigator
                                  .navigateToAndRemoveAllPreviousScreens(
                                thePageRouteName: AppRoutes.dashboardWrapper,
                                context: context,
                              ),
                            ),
                      ),
                    ],
                  )
                ],
              ),
            ).alignCenter(),
          ),
        ],
      ),
    );
  }
}
