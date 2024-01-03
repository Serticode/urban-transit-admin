import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urban_transit_admin/shared/utils/app_fade_animation.dart';
import 'package:urban_transit_admin/shared/utils/app_screen_utils.dart';
import 'package:urban_transit_admin/shared/utils/app_texts.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class SecuritySetupInvalidEmailError extends StatelessWidget {
  const SecuritySetupInvalidEmailError({super.key});

  @override
  Widget build(BuildContext context) => AppFadeAnimation(
        delay: 2.0,
        child: Container(
            padding: AppScreenUtils.containerPaddingSmall,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1.2.sp, color: AppThemeColours.appRedTransparent),
                borderRadius: BorderRadius.circular(5.0.r)),

            //! MAIN CONTENT
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              //! ICON
              const Icon(
                Icons.info_outline,
                size: 16,
                color: AppThemeColours.appRed,
              ),

              //! SPACER
              AppScreenUtils.horizontalSpaceSmall,

              //! TEXT
              Text(
                AppTexts.securitySetupInvalidEmail,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppThemeColours.appRed,
                    ),
              )
            ])),
      );
}
