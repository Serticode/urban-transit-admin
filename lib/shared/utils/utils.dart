import 'dart:async';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class AppUtils {
  const AppUtils._();

  //!
  //! MATERIAL BANNERS
  static Future<void> showAppBanner({
    required String title,
    required String message,
    required ContentType contentType,
    required BuildContext callerContext,
  }) async {
    ScaffoldMessenger.of(callerContext)
      ..clearMaterialBanners()
      ..showMaterialBanner(MaterialBanner(
        elevation: 0.1.sp,
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 21.0),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        forceActionsBelow: true,
        content: AwesomeSnackbarContent(
          title: title,
          message: message,
          contentType: contentType,
          inMaterialBanner: true,
          /* bgAsset: contentType == ContentType.failure
              ? AssetsPath.failure
              : contentType == ContentType.success
                  ? AssetsPath.success
                  : AssetsPath.bubbles, */
          color: contentType == ContentType.failure
              ? Colors.red.shade900
              : contentType == ContentType.success
                  ? Colors.green.shade900
                  : AppThemeColours.appBlue,
        ),
        actions: const [SizedBox.shrink()],
      ));

    Timer(const Duration(seconds: 2), () {
      ScaffoldMessenger.of(callerContext).hideCurrentMaterialBanner();
    });
  }

  //!
  static closeAppBanner({required BuildContext context}) =>
      ScaffoldMessenger.of(context).clearMaterialBanners();

//!
//! FETCH MONTH NAME
  static String getMonth({required DateTime dateTime}) {
    String theMonth = "";
    switch (dateTime.month) {
      case 1:
        theMonth = "Jan";
        return theMonth;
      case 2:
        theMonth = "Feb";
        return theMonth;
      case 3:
        theMonth = "Mar";
        return theMonth;
      case 4:
        theMonth = "Apr";
        return theMonth;
      case 5:
        theMonth = "May";
        return theMonth;
      case 6:
        theMonth = "Jun";
        return theMonth;
      case 7:
        theMonth = "Jul";
        return theMonth;
      case 8:
        theMonth = "Aug";
        return theMonth;
      case 9:
        theMonth = "Sep";
        return theMonth;
      case 10:
        theMonth = "Oct";
        return theMonth;
      case 11:
        theMonth = "Nov";
        return theMonth;
      case 12:
        theMonth = "Dec";
        return theMonth;

      //! DEFAULT VALUES
      default:
        theMonth = "Could not fetch the month";
        return theMonth;
    }
  }

  //!
  //! FETCH MONTH NAME
  static int getMonthNumber({required String monthName}) {
    int monthNumber = 0;
    switch (monthName) {
      case "Jan":
        monthNumber = 1;
        return monthNumber;
      case "Feb":
        monthNumber = 2;
        return monthNumber;
      case "Mar":
        monthNumber = 3;
        return monthNumber;
      case "Apr":
        monthNumber = 4;
        return monthNumber;
      case "May":
        monthNumber = 5;
        return monthNumber;
      case "Jun":
        monthNumber = 6;
        return monthNumber;
      case "Jul":
        monthNumber = 7;
        return monthNumber;
      case "Aug":
        monthNumber = 8;
        return monthNumber;
      case "Sep":
        monthNumber = 9;
        return monthNumber;
      case "Oct":
        monthNumber = 10;
        return monthNumber;
      case "Nov":
        monthNumber = 11;
        return monthNumber;
      case "Dec":
        monthNumber = 12;
        return monthNumber;

      //! DEFAULT VALUES
      default:
        monthNumber = 1;
        return monthNumber;
    }
  }

  //!
  static const List<String> listOfMonths = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  static const List<String> listOfDays = [
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun"
  ];

  static const List<Locale> appLocales = [
    Locale("af"),
    Locale("am"),
    Locale("ar"),
    Locale("az"),
    Locale("be"),
    Locale("bg"),
    Locale("bn"),
    Locale("bs"),
    Locale("ca"),
    Locale("cs"),
    Locale("da"),
    Locale("de"),
    Locale("el"),
    Locale("en"),
    Locale("es"),
    Locale("et"),
    Locale("fa"),
    Locale("fi"),
    Locale("fr"),
    Locale("gl"),
    Locale("ha"),
    Locale("he"),
    Locale("hi"),
    Locale("hr"),
    Locale("hu"),
    Locale("hy"),
    Locale("id"),
    Locale("is"),
    Locale("it"),
    Locale("ja"),
    Locale("ka"),
    Locale("kk"),
    Locale("km"),
    Locale("ko"),
    Locale("ku"),
    Locale("ky"),
    Locale("lt"),
    Locale("lv"),
    Locale("mk"),
    Locale("ml"),
    Locale("mn"),
    Locale("ms"),
    Locale("nb"),
    Locale("nl"),
    Locale("nn"),
    Locale("no"),
    Locale("pl"),
    Locale("ps"),
    Locale("pt"),
    Locale("ro"),
    Locale("ru"),
    Locale("sd"),
    Locale("sk"),
    Locale("sl"),
    Locale("so"),
    Locale("sq"),
    Locale("sr"),
    Locale("sv"),
    Locale("ta"),
    Locale("tg"),
    Locale("th"),
    Locale("tk"),
    Locale("tr"),
    Locale("tt"),
    Locale("uk"),
    Locale("ug"),
    Locale("ur"),
    Locale("uz"),
    Locale("vi"),
    Locale("zh")
  ];
}
