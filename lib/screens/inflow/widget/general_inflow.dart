//! GENERAL INFLOW WIDGET
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urban_transit_admin/services/controllers/drawer_controller.dart';
import 'package:urban_transit_admin/shared/utils/app_extensions.dart';
import 'package:urban_transit_admin/shared/utils/app_screen_utils.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class GeneralInflowWidget extends ConsumerWidget {
  final String date;
  final String amount;
  final int index;
  final String baseImage;
  final String topImage;

  const GeneralInflowWidget(
      {super.key,
      required this.date,
      required this.amount,
      required this.index,
      required this.baseImage,
      required this.topImage});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDrawerOpen = ref.watch(drawerOpenController);

    return isDrawerOpen.when(
      data: (drawerOpen) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 400.0.h,
          width: drawerOpen ? 350.0.w : 420.0.w,
          padding: EdgeInsets.only(left: 12.0.w, top: 18.0.h),
          decoration: BoxDecoration(
            color: index == 0
                ? const Color(0xFFCFFAC2)
                : index == 1
                    ? const Color(0xFFC8DCFF)
                    : const Color(0xFFFEE3CB),
            borderRadius: BorderRadius.circular(8.0.r),
            boxShadow: <BoxShadow>[
              BoxShadow(blurRadius: 12.0.r, color: Colors.grey.shade200)
            ],
          ),
          child: Stack(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                //! DATE
                Text(date),

                //! SPACER
                AppScreenUtils.verticalSpaceMedium,

                //! DATE
                Text(
                    index == 0
                        ? "Today's Inflow"
                        : index == 1
                            ? "Week's Inflow"
                            : "This Month's Inflow",
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(fontSize: 24.0.sp)),

                //! SPACER
                AppScreenUtils.verticalSpaceMedium,

                //! GIBBERISH
                Container(
                  height: 40.0.h,
                  width: 130.0.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0.r),
                      color: index == 0
                          ? const Color(0xFF9BED84)
                          : index == 1
                              ? const Color(0xFFAECCFF)
                              : const Color(0xFFFFCC9E)),
                  child: Center(
                    child: Text(
                      index == 0
                          ? "8 Drivers In Transit"
                          : index == 1
                              ? "16 Drivers In Transit"
                              : "20 Drivers In Transit",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 12.0.sp),
                    ),
                  ),
                ),

                //! SPACER
                const Spacer(),

                //! AMOUNT
                Text(amount,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontSize: 32.0.sp,
                          color: index == 0
                              ? AppThemeColours.appGreen
                              : index == 1
                                  ? AppThemeColours.appBlue
                                  : AppThemeColours.appAmber,
                        )),

                //! SPACER
                const Spacer()
              ]),

              //! IMAGES
              Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  height: 144.0.h,
                  width: 171.0.w,
                  child: Stack(
                    children: [
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(baseImage, fit: BoxFit.cover)),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(topImage, fit: BoxFit.cover))
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      error: (error, stackTrace) => "$error $stackTrace".txt(),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
