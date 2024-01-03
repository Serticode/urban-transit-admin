import 'package:flutter/material.dart';
import 'package:urban_transit_admin/router/routes.dart';
import 'package:urban_transit_admin/screens/auth/new_auth_setup/new_auth_setup.dart';
import 'package:urban_transit_admin/screens/auth/new_auth_setup/widget/auth_success_or_failure.dart';
import 'package:urban_transit_admin/screens/auth/otp_verification/otp_verification.dart';
import 'package:urban_transit_admin/screens/auth/sign_in/sign_in.dart';
import 'package:urban_transit_admin/screens/dashboard/dashboard_wrapper.dart';
import 'package:urban_transit_admin/screens/landing_page/landing_page.dart';

class AppNavigator {
  //! NAVIGATE TO A PAGE WITHOUT REPLACING THE PREVIOUS PAGE.
  static void navigateToPage(
          {required String thePageRouteName, required BuildContext context}) =>
      Navigator.of(context).pushNamed(thePageRouteName);

  //! NAVIGATE TO A PAGE AND REPLACE THE PREVIOUS PAGE
  static void navigateToReplacementPage(
          {required String thePageRouteName, required BuildContext context}) =>
      Navigator.of(context).pushReplacementNamed(thePageRouteName);

  //! PUSH NEW SCREEN AND REMOVE ALL SCREENS
  static void navigateToAndRemoveAllPreviousScreens(
          {required String thePageRouteName, required BuildContext context}) =>
      Navigator.of(context)
          .pushNamedAndRemoveUntil(thePageRouteName, (route) => false);

  //! ROUTE GENERATOR
  static Route<dynamic> generateRoute({required RouteSettings routeSettings}) {
    switch (routeSettings.name) {
      //! SECURITY SET UP
      case AppRoutes.securitySetup:
        return _getPageRoute(
            routeName: routeSettings.name,
            args: routeSettings.arguments,
            view: const LandingPage());

      //! OTP VERIFICATION
      case AppRoutes.otpVerification:
        return _getPageRoute(
            routeName: routeSettings.name,
            args: routeSettings.arguments,
            view: const OTPVerification());

      //! OTP VERIFICATION
      case AppRoutes.newAuthSetup:
        return _getPageRoute(
            routeName: routeSettings.name,
            args: routeSettings.arguments,
            view: const NewAuthSetup());

      //! AUTH SUCCESS OR FAILURE
      case AppRoutes.authSetupSuccessfulOrFailed:
        return _getPageRoute(
            routeName: routeSettings.name,
            args: routeSettings.arguments,
            view: const AuthSuccessOrFailure());

      //! LOGIN SCREEN
      case AppRoutes.loginScreen:
        return _getPageRoute(
            routeName: routeSettings.name,
            args: routeSettings.arguments,
            view: const SignInScreen());

      //! LOGIN SCREEN
      case AppRoutes.dashboardWrapper:
        return _getPageRoute(
            routeName: routeSettings.name,
            args: routeSettings.arguments,
            view: const DashboardWrapper());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                body: Center(
                    child:
                        Text('No route defined for ${routeSettings.name}'))));
    }
  }
}

//! GET A PAGE ROUTE
PageRoute _getPageRoute({String? routeName, Widget? view, Object? args}) =>
    MaterialPageRoute(
        settings: RouteSettings(name: routeName, arguments: args),
        builder: (_) => view!);
