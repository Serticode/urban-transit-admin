import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
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

//! OTP VERIFICATION CONTENT
class OTPVerification extends StatefulWidget {
  const OTPVerification({super.key});

  @override
  State<OTPVerification> createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  late final TextEditingController _emailController;

  //! IS PIN VALID
  bool _isPinValid = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //! TEXT STYLE
    final TextTheme textTheme = Theme.of(context).textTheme;

    //! PINPUT THEME
    final defaultPinTheme = PinTheme(
        width: 76.0,
        height: 80.0,
        textStyle: textTheme.bodyLarge!.copyWith(fontSize: 32.0),
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 2.0, color: AppThemeColours.appGreyBGColour))));

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
        border: Border(
            bottom: BorderSide(width: 2.0.h, color: AppThemeColours.appBlue)));

    final submittedPinTheme = defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
            border: Border.all(
                width: 1.4.w, color: AppThemeColours.appBlueTransparent),
            borderRadius: BorderRadius.circular(5.0.r),
            color: AppThemeColours.appBlueTransparent.withOpacity(0.3)));

    //! MAIN WIDGET
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => (sizingInformation
                      .screenSize.width >=
                  1440 &&
              sizingInformation.screenSize.height >= 768)
          ? Scaffold(
              body: Container(
                width: 720.0,
                height: 650.0,
                padding: AppScreenUtils.containerPadding,
                decoration: BoxDecoration(
                    color: AppThemeColours.appWhiteBGColour,
                    boxShadow: [
                      BoxShadow(
                          color:
                              AppThemeColours.appGreyBGColour.withOpacity(0.8),
                          blurRadius: 32.0.sp)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //! TITLE
                    AppFadeAnimation(
                        delay: 1.2,
                        child: Text(AppTexts.otpVerification,
                            style: textTheme.displayLarge)),

                    //! SPACER
                    AppScreenUtils.verticalSpaceMedium,

                    //! NOTICE
                    AppFadeAnimation(
                      delay: 1.4,
                      //! TODO: CHANGE THE MAIL BELOW
                      child: Text(
                        AppTexts.otpVerificationNotice(
                            userEmail: "nile***@staff.edu.ng"),
                        textAlign: TextAlign.center,
                        style: textTheme.displayMedium,
                      ).alignCenter(),
                    ),

                    //! SPACER
                    AppScreenUtils.verticalSpaceMedium,

                    //! PINPUT SECTION
                    AppFadeAnimation(
                      delay: 2.2,
                      child: Pinput(
                        length: 5,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        submittedPinTheme: submittedPinTheme,

                        //! IF THERE IS AN ERROR MESSAGE
                        errorTextStyle: textTheme.bodyMedium!.copyWith(
                            color: AppThemeColours.appRed,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0.sp),

                        //! VALIDATOR
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter the sent pin";
                          } else if (value == 12345.toString()) {
                            setState(() => _isPinValid = true);
                            return null;
                          } else {
                            return "Entered pin is incorrect";
                          }
                        },

                        //! OTHERS
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        showCursor: true,
                        onCompleted: (pin) => log(pin),
                      ).alignCenter(),
                    ),

                    //! SPACER
                    AppScreenUtils.verticalSpaceLarge,

                    //! BUTTON
                    AppFadeAnimation(
                      delay: 2.0,
                      child: AppElevatedButton(
                        //! ON PRESSED
                        onPressed: () {
                          _isPinValid
                              ? AppNavigator.navigateToPage(
                                  thePageRouteName: AppRoutes.newAuthSetup,
                                  context: context)
                              : {};
                        },
                        buttonTitle: AppTexts.verifyOTP,
                        buttonColour: AppThemeColours.appGreen,
                      ).alignCenter(),
                    ),

                    //! SPACER
                    AppScreenUtils.verticalSpaceLarge,

                    //! RESEND OTP
                    Center(
                        child: TextButton(
                            onPressed: () {},
                            child: Text(AppTexts.resendOTP,
                                style: textTheme.bodyMedium!.copyWith(
                                    color: AppThemeColours.appBlue)))),

                    //! SPACER
                    AppScreenUtils.verticalSpaceMedium
                  ],
                ).generalPadding,
              ).generalPadding.generalPadding.alignCenter(),
            )
          : const ResizeToDesktopScreen(),
    );
  }
}
