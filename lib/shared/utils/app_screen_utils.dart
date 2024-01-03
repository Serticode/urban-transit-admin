import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urban_transit_admin/theme/theme.dart';

abstract class AppScreenUtils {
  //! PADDING
  static const EdgeInsets headerPadding =
      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0);
  static const EdgeInsets headerButtonPadding =
      EdgeInsets.symmetric(vertical: 21.0, horizontal: 24.0);
  static const EdgeInsets listOfVaccinesPadding =
      EdgeInsets.symmetric(vertical: 16.0, horizontal: 21.0);
  static const EdgeInsets dashboardNavPadding =
      EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0);
  static EdgeInsets containerPadding =
      const EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0);
  static EdgeInsets containerPaddingCustom =
      const EdgeInsets.only(top: 32.0, left: 18.0, right: 18.0);
  static EdgeInsets containerPaddingSmall =
      const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0);

  static EdgeInsets containerPaddingTiny =
      const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0);

  //! PADDING - BUTTONS
  static EdgeInsets textButtonPadding =
      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0);
  static EdgeInsets elevatedButtonDefaultPadding =
      const EdgeInsets.symmetric(vertical: 9.0, horizontal: 13.0);

  //! PADDING - TEXT FORM FIELDS
  static const EdgeInsets textFormFieldDefaultPadding =
      EdgeInsets.symmetric(vertical: 18.0, horizontal: 32.0);

  //! CHAT PADDING
  //! CHAT PADDING
  static EdgeInsets appChatPadding =
      const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0);

  //! CHAT PADDING
  static EdgeInsets notificationChatPadding =
      const EdgeInsets.symmetric(vertical: 16.0, horizontal: 14.0);

  //! IS MOBILE
  static bool isMobile({bool? isMobile}) =>
      isMobile != null && isMobile == true;

  //! SPACERS
  static Widget horizontalSpaceSmall = SizedBox(width: 10.0.w);
  static Widget horizontalSpaceMedium = SizedBox(width: 25.0.w);
  static Widget horizontalSpaceLarge = SizedBox(width: 75.0.w);

  static Widget verticalSpaceSmall = SizedBox(height: 10.0.h);
  static Widget verticalSpaceMedium = SizedBox(height: 25.0.h);
  static Widget verticalSpaceLarge = SizedBox(height: 70.0.h);

  //! GET TODAYS DATE
  static String getTodaysDate() {
    String todaysDate = "";

    //! GET THE DATE / TIME
    final DateTime dateTime = DateTime.now();
    String theMonth = getMonth(dateTime: dateTime);
    String theDay = getDay(dateTime: dateTime);

    todaysDate = "$theDay ${dateTime.day} $theMonth, ${dateTime.year}";

    return todaysDate;
  }

  //! FETCH MONTH NAME
  static String getMonth({required DateTime dateTime}) {
    String theMonth = "";
    switch (dateTime.month) {
      case 1:
        theMonth = "January";
        return theMonth;
      case 2:
        theMonth = "February";
        return theMonth;
      case 3:
        theMonth = "March";
        return theMonth;
      case 4:
        theMonth = "April";
        return theMonth;
      case 5:
        theMonth = "May";
        return theMonth;
      case 6:
        theMonth = "June";
        return theMonth;
      case 7:
        theMonth = "July";
        return theMonth;
      case 8:
        theMonth = "August";
        return theMonth;
      case 9:
        theMonth = "September";
        return theMonth;
      case 10:
        theMonth = "October";
        return theMonth;
      case 11:
        theMonth = "November";
        return theMonth;
      case 12:
        theMonth = "December";
        return theMonth;

      //! DEFAULT VALUES
      default:
        theMonth = "Could not fetch the month";
        return theMonth;
    }
  }

  static String getDay({required DateTime dateTime}) {
    String theDay = "";
    switch (dateTime.month) {
      case 1:
        theDay = "Monday";
        return theDay;
      case 2:
        theDay = "Tuesday";
        return theDay;
      case 3:
        theDay = "Wednesday";
        return theDay;
      case 4:
        theDay = "Thursday";
        return theDay;
      case 5:
        theDay = "Friday";
        return theDay;
      case 6:
        theDay = "Saturday";
        return theDay;
      case 7:
        theDay = "Sunday";
        return theDay;

      //! DEFAULT VALUES
      default:
        theDay = "Could not fetch the month";
        return theDay;
    }
  }

  //! SHOW GENERAL DIALOGUE
  static showAppDialogBox({
    required BuildContext theBuildContext,
    required Widget child,
    required double width,
    required double height,
    bool? isBGTransparent,
  }) =>
      showGeneralDialog(

          //!SHADOW EFFECT
          barrierColor: AppThemeColours.appDialogueBarrierColour,

          //! OTHER NEEDED PARAMETERS
          barrierDismissible: false,
          barrierLabel: "App Default Dialogue",
          context: theBuildContext,

          //! USE PROVIDED ANIMATION
          transitionBuilder: (context, a1, a2, widget) => Dialog(
              elevation: 40.0,
              backgroundColor: isBGTransparent != null
                  ? AppThemeColours.appWhiteBGColour.withOpacity(0.2)
                  : AppThemeColours.appWhiteBGColour,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.r)),
              child: SizedBox(
                  height: height * a1.value,
                  width: width * a1.value,
                  child: Padding(
                    padding: containerPadding,
                    child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(), child: child),
                  ))),

          //! ANIMATION DURATION
          transitionDuration: const Duration(milliseconds: 200),

          //! STILL DON'T KNOW WHAT THIS DOES, BUT IT'S REQUIRED
          pageBuilder: (context, animation1, animation2) => const Text(""));

  //! SHOW GENERAL DIALOGUE
  static showAppCallDialogue({
    required BuildContext theBuildContext,
    required Widget child,
    required double width,
    required double height,
    bool? isBGTransparent,
  }) =>
      showGeneralDialog(

          //!SHADOW EFFECT
          barrierColor: AppThemeColours.appDialogueBarrierColour,

          //! OTHER NEEDED PARAMETERS
          barrierDismissible: false,
          barrierLabel: "App Call Dialogue",
          context: theBuildContext,

          //! USE PROVIDED ANIMATION
          transitionBuilder: (context, a1, a2, widget) => Dialog(
              elevation: 40.0,
              backgroundColor: isBGTransparent != null
                  ? AppThemeColours.appWhiteBGColour.withOpacity(0.2)
                  : AppThemeColours.appWhiteBGColour,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.r)),
              child: SizedBox(
                  height: height * a1.value,
                  width: width * a1.value,
                  child: Padding(padding: containerPadding, child: child))),

          //! ANIMATION DURATION
          transitionDuration: const Duration(milliseconds: 200),

          //! STILL DON'T KNOW WHAT THIS DOES, BUT IT'S REQUIRED
          pageBuilder: (context, animation1, animation2) => const Text(""));
}
