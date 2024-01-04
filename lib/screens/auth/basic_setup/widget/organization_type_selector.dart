import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urban_transit_admin/services/controllers/organization_type_controller.dart';
import 'package:urban_transit_admin/shared/utils/app_extensions.dart';
import 'package:urban_transit_admin/shared/utils/type_defs.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class OrganizationTypeSelector extends ConsumerWidget {
  const OrganizationTypeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<OrganizationType> items = ref
        .read(organizationTypeControllerProvider.notifier)
        .getAllOrganizationTypes;

    final AsyncValue<OrganizationType> organizationType =
        ref.watch(organizationTypeControllerProvider);

    return Container(
      padding: 6.0.symmetricPadding,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12, width: 1.2.w),
        borderRadius: BorderRadius.circular(3),
      ),
      width: 679.0.w,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<OrganizationType>(
          isExpanded: false,
          style: TextStyle(
            fontFamily: "inter",
            letterSpacing: 1.1.sp,
            fontWeight: FontWeight.w300,
            fontSize: 16.0.sp,
          ),

          customButton: Row(
            children: [
              Expanded(
                child: organizationType.value!.orgName.txt(
                  color: AppThemeColours.bodyText2TextColour,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0.sp,
                ),
              ),
              Container(
                width: 39.0.w,
                height: 39.0.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppThemeColours.appBlueTransparent.withOpacity(0.5),
                ),
                child: const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppThemeColours.appBlue,
                ),
              ),
            ],
          ),

          menuItemStyleData: MenuItemStyleData(
            height: 60.0.h,
            padding: 21.0.symmetricPadding,
          ),

          //! DROP DOWN
          dropdownStyleData: DropdownStyleData(
            elevation: 0,
            openInterval: const Interval(0.1, 0.6, curve: Curves.easeIn),
            width: 679.0.w,
            decoration: BoxDecoration(
              color: AppThemeColours.appWhiteBGColour,
              borderRadius: BorderRadius.circular(1),
              border: Border.all(color: AppThemeColours.appGreyBGColour),
            ),
            offset: Offset(-9.0.w, -20.0.h),
            scrollbarTheme: ScrollbarThemeData(
              radius: Radius.circular(40.0.r),
              thickness: MaterialStateProperty.all(3.sp),
              thumbVisibility: MaterialStateProperty.all(true),
            ),
          ),

          //!
          items: items
              .map(
                (OrganizationType item) => DropdownMenuItem<OrganizationType>(
                  value: item,
                  child: item.orgName.txt(
                    color: AppThemeColours.bodyText2TextColour,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0.sp,
                  ),
                ),
              )
              .toList(),

          value: organizationType.value,
          onChanged: (OrganizationType? newOrganizationType) => ref
              .read(organizationTypeControllerProvider.notifier)
              .setOrganizationType(
                organizationType:
                    newOrganizationType ?? OrganizationType.transportCompany,
              ),
        ),
      ),
    );
  }
}
