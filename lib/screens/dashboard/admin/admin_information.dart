import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
          const Expanded(child: AdminInformationSection()),

          //! SPACER
          AppScreenUtils.horizontalSpaceMedium,

          //! RIGHT SIDE
          const Expanded(child: BussesSection())
        ],
      ),
    );
  }
}
