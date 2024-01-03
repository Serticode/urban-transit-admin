import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:urban_transit_admin/shared/utils/app_extensions.dart';
import 'package:urban_transit_admin/shared/utils/app_screen_utils.dart';
import 'package:urban_transit_admin/screens/dashboard/admin/widget/admin_info_section.dart';
import 'package:urban_transit_admin/screens/dashboard/admin/widget/busses_section.dart';

class AdminInformation extends ConsumerWidget {
  const AdminInformation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: AppScreenUtils.containerPadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //! LEFT SIDE
          Expanded(child: const AdminInformationSection().fadeInFromBottom()),

          //! SPACER
          AppScreenUtils.horizontalSpaceMedium,

          //! RIGHT SIDE
          Expanded(
            child: const BussesSection().fadeInFromBottom(
              delay: const Duration(milliseconds: 400),
            ),
          )
        ],
      ),
    );
  }
}
