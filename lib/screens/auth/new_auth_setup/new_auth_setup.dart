import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:urban_transit_admin/screens/resize_to_desktop/resize_to_desktop.dart';
import 'package:urban_transit_admin/shared/utils/app_extensions.dart';
import 'package:urban_transit_admin/shared/utils/app_fade_animation.dart';
import 'package:urban_transit_admin/shared/utils/app_screen_utils.dart';
import 'package:urban_transit_admin/shared/utils/app_texts.dart';
import 'package:urban_transit_admin/screens/widgets/app_elevated_button.dart';
import 'package:urban_transit_admin/screens/widgets/app_text_form_field.dart';
import 'package:urban_transit_admin/router/router.dart';
import 'package:urban_transit_admin/router/routes.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class NewAuthSetup extends StatefulWidget {
  final String? theUserEmail;
  const NewAuthSetup({super.key, this.theUserEmail});

  @override
  State<NewAuthSetup> createState() => _NewAuthSetupState();
}

class _NewAuthSetupState extends State<NewAuthSetup> {
  late final TextEditingController _userNameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //! TEXT STYLE
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ResponsiveBuilder(
      builder: (context, sizingInformation) => (sizingInformation
                      .screenSize.width >=
                  1440 &&
              sizingInformation.screenSize.height >= 768)
          ? Scaffold(
              backgroundColor: AppThemeColours.appWhiteBGColour,
              body: Container(
                width: 771.0.w,
                height: 814.0.h,
                padding: AppScreenUtils.containerPadding,
                decoration: BoxDecoration(
                    color: AppThemeColours.appWhiteBGColour,
                    boxShadow: [
                      BoxShadow(
                        color: AppThemeColours.appGreyBGColour.withOpacity(0.8),
                        blurRadius: 32.0.sp,
                      )
                    ]),

                //! MAIN WIDGET
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //! TITLE
                      AppFadeAnimation(
                        delay: 1.2,
                        child: Text(AppTexts.newAuthSetup,
                            style: textTheme.displayLarge),
                      ),

                      //! SPACER
                      AppScreenUtils.verticalSpaceMedium,

                      //! SHOWED EMAIL
                      AppFadeAnimation(
                          delay: 1.4,
                          child: Container(
                              padding: AppScreenUtils.containerPaddingSmall,
                              width: double.infinity.w,
                              decoration: BoxDecoration(
                                  color: AppThemeColours.appBlueTransparent,
                                  border: Border.all(
                                      width: 1.2.sp,
                                      color: AppThemeColours.appBlue),
                                  borderRadius: BorderRadius.circular(5.0.r)),
                              child: Text(AppTexts.defaultEmail,
                                  style: textTheme.bodyMedium))),

                      //! SPACER
                      AppScreenUtils.verticalSpaceMedium,

                      //! CHOOSE A USER NAME
                      //! LABEL
                      Text(AppTexts.chooseAUserName,
                          style: textTheme.bodyLarge),

                      //! SPACER
                      AppScreenUtils.verticalSpaceSmall,

                      //! USER NAME
                      AppTextFormField(
                          hintText: AppTexts.yourUsername,
                          controller: _userNameController,
                          onChanged: (textContent) {}),

                      //! SPACER
                      AppScreenUtils.verticalSpaceMedium,

                      //! NEW PASSWORD
                      //! LABEL
                      Text(AppTexts.newPassword, style: textTheme.bodyLarge),

                      //! SPACER
                      AppScreenUtils.verticalSpaceSmall,

                      //! PASSWORD
                      AppTextFormField(
                          hintText: AppTexts.yourPassword,
                          controller: _passwordController,
                          onChanged: (textContent) {}),

                      //! SPACER
                      AppScreenUtils.verticalSpaceMedium,

                      //! CONFIRM PASSWORD
                      //! LABEL
                      Text(AppTexts.confirmPassword,
                          style: textTheme.bodyLarge),

                      //! SPACER
                      AppScreenUtils.verticalSpaceSmall,

                      //! CONFIRM PASSWORD
                      AppTextFormField(
                          hintText: AppTexts.yourPassword,
                          controller: _confirmPasswordController,
                          onChanged: (textContent) {}),

                      //! SPACER
                      AppScreenUtils.verticalSpaceMedium,

                      //! BUTTON
                      AppFadeAnimation(
                          delay: 1.6,
                          child: SizedBox(
                            width: double.infinity,
                            child: AppElevatedButton(
                              //! ON PRESSED
                              onPressed: () {
                                AppNavigator.navigateToPage(
                                    thePageRouteName:
                                        AppRoutes.authSetupSuccessfulOrFailed,
                                    context: context);
                              },
                              buttonTitle: AppTexts.setupDetails,
                            ),
                          )),
                    ],
                  ),
                ).generalPadding,
              ).alignCenter(),
            )
          : const ResizeToDesktopScreen(),
    );
  }
}
