// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urban_transit_admin/shared/utils/app_extensions.dart';
import 'package:urban_transit_admin/shared/utils/app_fade_animation.dart';
import 'package:urban_transit_admin/shared/utils/app_screen_utils.dart';
import 'package:urban_transit_admin/screens/inflow/widget/current_flow.dart';
import 'package:urban_transit_admin/screens/inflow/widget/drivers_inflow.dart';
import 'package:urban_transit_admin/screens/inflow/widget/general_inflow.dart';

class Inflow extends ConsumerWidget {
  const Inflow({super.key});
  static final List<String> baseImage = [
    "lib/assets/images/inflow_green_base.png",
    "lib/assets/images/inflow_blue_base.png",
    "lib/assets/images/inflow_orange_base.png"
  ];
  static final List<String> topImage = [
    "lib/assets/images/inflow_green_top.png",
    "lib/assets/images/inflow_blue_top.png",
    "lib/assets/images/inflow_orange_top.png"
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      //! SPACER
      AppScreenUtils.verticalSpaceSmall,

      //! TOP
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          3,
          (index) => AppFadeAnimation(
            delay: (index + 0.5).toDouble(),
            child: GeneralInflowWidget(
              date: "Wednesday 23rd May,2022",
              amount: "#500,000",
              index: index,
              baseImage: baseImage[index],
              topImage: topImage[index],
            ),
          ),
        ),
      ),

      //! BASE - CURRENT FLOW & DRIVERS FLOW
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
              child: AppFadeAnimation(delay: 1.2, child: CurrentFlow())),

          //! DRIVERS INFLOW
          Expanded(child: AppFadeAnimation(delay: 1.4, child: DriversInflow()))
        ],
      ),

      //! SPACER
      AppScreenUtils.verticalSpaceSmall
    ]).generalPadding;
  }
}
