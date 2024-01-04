import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:urban_transit_admin/screens/resize_to_desktop/resize_to_desktop.dart';
import 'package:urban_transit_admin/shared/utils/app_extensions.dart';
import 'package:urban_transit_admin/shared/utils/app_fade_animation.dart';
import 'package:urban_transit_admin/shared/utils/app_screen_utils.dart';
import 'package:urban_transit_admin/shared/utils/app_texts.dart';
import 'package:urban_transit_admin/screens/widgets/app_elevated_button.dart';
import 'package:urban_transit_admin/router/router.dart';
import 'package:urban_transit_admin/router/routes.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class AuthSuccessOrFailure extends StatelessWidget {
  const AuthSuccessOrFailure({super.key});

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
                width: 800.0.w,
                height: 820.0.h,
                padding: AppScreenUtils.containerPadding,
                decoration: BoxDecoration(
                  color: AppThemeColours.appWhiteBGColour,
                  boxShadow: [
                    BoxShadow(
                        color: AppThemeColours.appGreyBGColour.withOpacity(0.8),
                        blurRadius: 32.0.sp)
                  ],
                ),

                //! MAIN WIDGET
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //! TITLE
                    AppFadeAnimation(
                        delay: 1.2,
                        child: Text(AppTexts.authSuccessfulHeader,
                            style: textTheme.bodyLarge)),

                    //! SPACER
                    AppScreenUtils.verticalSpaceMedium,

                    //! CIRCLE
                    CircleAvatar(
                        radius: 150.0.r,
                        backgroundColor: AppThemeColours.appGreenTransparent,
                        child: CircleAvatar(
                            radius: 120.0.r,
                            backgroundColor: AppThemeColours.appGreen,
                            child: Icon(Icons.done_outlined,
                                size: 90.0.sp,
                                color: AppThemeColours.appWhiteBGColour))),

                    //! SPACER
                    AppScreenUtils.verticalSpaceMedium,

                    //! ADMIN TITLE
                    //!TODO: ADD CORRECT ADMIN HERE
                    Text(AppTexts.nileAdmin, style: textTheme.bodyLarge),

                    //! SPACER
                    AppScreenUtils.verticalSpaceMedium,

                    //! SUCCESS NOTICE
                    Text(
                      AppTexts.authSuccessNotice,
                      style: textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),

                    //! SPACER
                    AppScreenUtils.verticalSpaceMedium,

                    //! BUTTON
                    AppFadeAnimation(
                      delay: 1.6,
                      child: AppElevatedButton(
                        onPressed: () {
                          AppNavigator.navigateToPage(
                              thePageRouteName: AppRoutes.loginScreen,
                              context: context);
                        },
                        buttonTitle: AppTexts.getStarted,
                      ),
                    )
                  ],
                ),
              ).alignCenter(),
            )
          : const ResizeToDesktopScreen(),
    );
  }
}
