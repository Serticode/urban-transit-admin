import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:urban_transit_admin/router/router.dart';
import 'package:urban_transit_admin/screens/dashboard/dashboard_wrapper.dart';
import 'package:urban_transit_admin/screens/landing_page/landing_page.dart';
import 'package:urban_transit_admin/screens/resize_to_desktop/resize_to_desktop.dart';
import 'package:urban_transit_admin/shared/utils/app_texts.dart';
import 'package:urban_transit_admin/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(child: UrbanTransitAdmin()),
  );
}

class UrbanTransitAdmin extends ConsumerStatefulWidget {
  const UrbanTransitAdmin({super.key});

  @override
  ConsumerState<UrbanTransitAdmin> createState() => _UrbanTransitAdminState();
}

class _UrbanTransitAdminState extends ConsumerState<UrbanTransitAdmin> {
  @override
  Widget build(BuildContext context) => ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: false,
        //! 1440 BY 1024 - THAT'S THE LAYOUT GIVEN ON THE DESIGN BOARD
        designSize: const Size(1440, 1024),

        //! MAIN APP
        builder: (context, child) => ResponsiveBuilder(
          builder: (context, sizingInformation) => MaterialApp(
            title: AppTexts.appName,
            theme: AppTheme.theTheme,
            debugShowCheckedModeBanner: false,
            scrollBehavior: const MaterialScrollBehavior()
                .copyWith(scrollbars: false, dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
              PointerDeviceKind.stylus,
            }),
            onGenerateRoute: (settings) => AppNavigator.generateRoute(
              routeSettings: settings,
            ),
            home: // sizingInformation.screenSize.height.toString().log();
                (sizingInformation.screenSize.width >= 1440 &&
                        sizingInformation.screenSize.height >= 768)
                    ? const DashboardWrapper() //LandingPage()
                    : const ResizeToDesktopScreen(),
          ),
        ),
      );
}
