import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urban_transit_admin/shared/utils/app_screen_utils.dart';

class AppTheme {
  static ThemeData get theTheme => ThemeData(
        //! HOW PAGES TRANSITION BETWEEN EACH OTHER
        //! ASSIGN ALL PLATFORMS TO TRANSITION USING THE ZOOM PAGE TRANSITION
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            for (final platform in TargetPlatform.values)
              platform: const ZoomPageTransitionsBuilder()
          },
        ),
        scaffoldBackgroundColor: AppThemeColours.scaffoldBackgroundColour,
        useMaterial3: false,
        shadowColor: AppThemeColours.shadowColour,

        //! ICONS
        iconTheme:
            IconThemeData(size: 21.0.sp, color: AppThemeColours.iconColour),
        fontFamily: "Inter",

        //! TEXT
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 36.0,
              fontWeight: FontWeight.w800,
              color: AppThemeColours.header1TextColour),
          displayMedium: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: AppThemeColours.header2TextColour),
          bodyLarge: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: AppThemeColours.bodyText1TextColour),
          bodyMedium: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: AppThemeColours.bodyText2TextColour),
        ),

        //! ELEVATED BUTTON
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: AppScreenUtils.elevatedButtonDefaultPadding,
            backgroundColor: AppThemeColours.elevatedButtonBackgroundColour,
            textStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: AppThemeColours.elevatedButtonTextColour,
                fontSize: 18.0.sp),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0.r),
            ),
          ),
        ),

        colorScheme: ColorScheme.fromSwatch()
            .copyWith(
                primary: AppThemeColours.primaryColour,
                secondary: AppThemeColours.secondaryColour,
                tertiary: AppThemeColours.tertiaryColour,
                shadow: AppThemeColours.shadowColour)
            .copyWith(background: AppThemeColours.backgroundColour),
      );
}

//! THEME COLOURS.
abstract class AppThemeColours {
  //! MAIN COLOUR
  static const Color primaryColour = Color(0xFF1C4DA1);
  static const Color secondaryColour = Color(0xFF68BF50);
  static const Color tertiaryColour = Color(0xFFD40909);

  //! BASE COLOURS
  static const Color appBlue = Color(0xFF1C4DA1);
  static const Color appGreen = Color(0xFF68BF50);
  static const Color appRed = Color(0xFFD40909);
  static const Color appGrey = Color(0xFF828282);
  static final Color appAmber = Colors.amber.shade800;
  static const Color appDialogueBarrierColour = Colors.black38;
  static const Color appWhiteBGColour = Color(0xFFFFFFFF);
  static const Color appGreyBGColour = Color(0xFFE5E5E5);
  static const Color textFormFieldBGColour = Color(0xFFF2F2F2);
  static const Color textFormFieldUnfocusedBorderColour = Color(0xFFBDBDBD);

  //! BASE COLOURS WITH TRANSPARENCY
  static const Color appBlueTransparent = Color(0xFFC8DCFF);
  static const Color appGreenTransparent = Color(0xFFCBFFBC);
  static const Color appRedTransparent = Color(0xFFFFAEAE);

  //! BUTTON COLOURS
  static const Color inActiveButton = Color(0xFFBDBDBD);
  static const Color activeButtonBlue = Color(0xFF1C4DA1);
  static const Color activeButtonGreen = Color(0xFF68BF50);

  //! BUTTON COLOURS - BACKGROUND

  //! ICON COLOURS
  static const Color iconColour = Color(0xFF1C4DA1);
  static const Color iconBGColour = Color(0xFF5C6266);
  static const Color hoverColour = Color(0Xffb6542b);

  //! BACKGROUND COLOURS
  static Color backgroundColour = Colors.white;
  static Color scaffoldBackgroundColour = Colors.white;
  static Color backgroundColourGrey = Colors.grey.shade100;

  //! SHADOW COLOUR
  static Color shadowColour = const Color(0xFF1C4DA1).withOpacity(0.2);

  //! TEXT COLOURS
  static const Color header1TextColour = Color(0xFF333333);
  static const Color header2TextColour = Color(0xFF828282);
  static const Color bodyText1TextColour = Color(0xFF4F4F4F);
  static const Color bodyText2TextColour = Color(0xFF828282);
  static const Color textFormFieldLabelColour = Color(0xFF4F4F4F);
  static const Color elevatedButtonTextColour = Color(0XffFFFFFF);
  static Color lettersAndIconsFaintColour = const Color(0xFF565759);
  static Color focusedTextFormFieldColour = const Color(0xFFFEA742);
  static const Color black = Color(0xFF333333);

  //! ELEVATED BUTTON AND CONTAINERS
  static Color elevatedButtonBackgroundColour = const Color(0xFFBDBDBD);
  static Color containersBackgroundColourPrimary = Colors.white;
  static Color containersBackgroundColourSecondary = const Color(0xFF273EBD);

  //! SNACK BAR
  static Color snackbarBackgroundColour = const Color(0xFF0D0811);
}
