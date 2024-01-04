import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urban_transit_admin/shared/utils/app_extensions.dart';
import 'package:urban_transit_admin/shared/utils/app_images.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class ResizeToDesktopScreen extends ConsumerStatefulWidget {
  const ResizeToDesktopScreen({super.key});

  @override
  ConsumerState<ResizeToDesktopScreen> createState() =>
      _ResizeToDesktopScreenState();
}

class _ResizeToDesktopScreenState extends ConsumerState<ResizeToDesktopScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppThemeColours.appWhiteBGColour,
              AppThemeColours.appBlueTransparent,
            ],
          ),
        ),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) => AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            width: 1080.0.w,
            height: 720.0.h,
            margin: EdgeInsets.only(top: _animationController.value * 50),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: AppThemeColours.appWhiteBGColour,
                boxShadow: [
                  BoxShadow(
                    color: AppThemeColours.appGreyBGColour.withOpacity(0.8),
                    blurRadius: 32.0.sp,
                  )
                ]),

            //! CONTENT
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppThemeColours.appBlueTransparent,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    child: Image.asset(AppImages.resizeToDesktop),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        "🚀".txt(fontSize: 98),
                        "Oops".txt(fontSize: 82, fontWeight: FontWeight.bold),
                        12.0.sizedBoxHeight,
                        "Kindly resize to desktop view".txt(
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center),
                        21.0.sizedBoxHeight,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ).alignCenter(),
        ),
      ),
    );
  }
}
