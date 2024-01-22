import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:urban_transit_admin/screens/dashboard/map/dashboard_map.dart';
import 'package:urban_transit_admin/screens/dashboard/messaging/inbox_view.dart';
import 'package:urban_transit_admin/shared/utils/app_extensions.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class BasicSetupShimmer extends ConsumerWidget {
  const BasicSetupShimmer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade500,
          highlightColor: Colors.grey.shade300,
          child: const DashboardMap(),
        ),
        Stack(
          children: [
            Shimmer.fromColors(
              baseColor: AppThemeColours.appGrey.withOpacity(0.5),
              highlightColor: AppThemeColours.appGreyBGColour.withOpacity(0.5),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * 0.15,
                decoration: const BoxDecoration(
                  color: AppThemeColours.appGreyBGColour,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(21.0),
                    bottomRight: Radius.circular(21.0),
                  ),
                ),
              ),
            ).align(
              Alignment.topLeft,
            ),

            //!
            Shimmer.fromColors(
              baseColor: AppThemeColours.appGrey.withOpacity(0.5),
              highlightColor: AppThemeColours.appGreyBGColour.withOpacity(0.5),
              child: DashboardInboxView(
                height: MediaQuery.of(context).size.height * 0.1,
                minimize: () {},
                maximize: () {},
                close: () {},
              ),
            ).generalVerticalPadding.align(
                  Alignment.topRight,
                ),

            //!
            Shimmer.fromColors(
              baseColor: AppThemeColours.appGrey.withOpacity(0.5),
              highlightColor: AppThemeColours.appGreyBGColour.withOpacity(0.5),
              child: DashboardInboxView(
                height: MediaQuery.of(context).size.height * 0.1,
                minimize: () {},
                maximize: () {},
                close: () {},
              ),
            ).generalVerticalPadding.align(
                  Alignment.bottomRight,
                ),
          ],
        )
      ],
    );
  }
}
