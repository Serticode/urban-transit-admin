import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urban_transit_admin/shared/utils/app_extensions.dart';
import 'package:urban_transit_admin/shared/utils/app_fade_animation.dart';
import 'package:urban_transit_admin/shared/utils/app_screen_utils.dart';
import 'package:urban_transit_admin/shared/utils/app_texts.dart';
import 'package:urban_transit_admin/screens/widgets/app_elevated_button.dart';
import 'package:urban_transit_admin/screens/widgets/app_text_form_field.dart';
import 'package:urban_transit_admin/router/router.dart';
import 'package:urban_transit_admin/router/routes.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late final TextEditingController _userNameController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _userNameController.clear();
    _passwordController.clear();
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //! TEXT STYLE
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Container(
        width: 640.0.w,
        height: 592.0.h,
        padding: AppScreenUtils.containerPadding,
        decoration:
            BoxDecoration(color: AppThemeColours.appWhiteBGColour, boxShadow: [
          BoxShadow(
            color: AppThemeColours.appGreyBGColour.withOpacity(0.8),
            blurRadius: 32.0.sp,
          )
        ]),

        //! MAIN BODY
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //! TITLE
            AppFadeAnimation(
                delay: 1.2,
                child:
                    Text(AppTexts.welcomeBack, style: textTheme.displayLarge)),

            //! SPACER
            AppScreenUtils.verticalSpaceMedium,

            //! CHOOSE A USER NAME
            //! LABEL
            Text(AppTexts.chooseAUserName, style: textTheme.bodyLarge),

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

            //! BUTTON
            AppFadeAnimation(
              delay: 1.6,
              child: AppElevatedButton(
                onPressed: () {
                  AppNavigator.navigateToAndRemoveAllPreviousScreens(
                    thePageRouteName: AppRoutes.dashboardWrapper,
                    context: context,
                  );
                },
                buttonTitle: AppTexts.login,
              ),
            ),
          ],
        ).generalPadding,
      ).alignCenter(),
    );
  }
}
