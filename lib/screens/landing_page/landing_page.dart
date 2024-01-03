import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urban_transit_admin/shared/utils/app_extensions.dart';
import 'package:urban_transit_admin/shared/utils/app_screen_utils.dart';
import 'package:urban_transit_admin/screens/auth/security_setup/security_setup.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class LandingPage extends ConsumerWidget {
  final Widget? child;
  const LandingPage({super.key, this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        backgroundColor: AppThemeColours.appWhiteBGColour,
        body: Container(
          width: 720.0,
          height: 650.0,
          padding: AppScreenUtils.containerPadding,
          decoration: BoxDecoration(
              color: AppThemeColours.appWhiteBGColour,
              boxShadow: [
                BoxShadow(
                    color: AppThemeColours.appGreyBGColour.withOpacity(0.8),
                    blurRadius: 32.0.sp)
              ]),

          //! CONTENT
          child: child ?? const SecuritySetupScreen(),
        ).alignCenter(),
      );
}
