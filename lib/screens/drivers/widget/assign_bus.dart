import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urban_transit_admin/shared/utils/app_screen_utils.dart';
import 'package:urban_transit_admin/shared/utils/app_texts.dart';
import 'package:urban_transit_admin/screens/widgets/app_elevated_button.dart';
import 'package:urban_transit_admin/screens/widgets/app_text_form_field.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class AssignBus extends StatelessWidget {
  AssignBus({super.key});
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _amountToBePaidController =
      TextEditingController();
  final TextEditingController _busNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //! TEXT STYLE
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      //! BUS NUMBER
      Text(AppTexts.busNumber,
          style: textTheme.bodyLarge!.copyWith(fontSize: 14.0.sp)),

      //! SPACER
      AppScreenUtils.verticalSpaceSmall,

      //! BUS NUMBER TEXT FIELD
      AppTextFormField(controller: _busNumber, hintText: "AK76854J"),

      //! SPACER
      AppScreenUtils.verticalSpaceMedium,

      //! BUS SCHEDULE
      Text(AppTexts.busSchedule,
          style: textTheme.bodyLarge!.copyWith(fontSize: 14.0.sp)),

      //! OTHERS - FROM - TO
      Row(children: [
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //! FROM
          Text(AppTexts.from,
              style: textTheme.bodyLarge!.copyWith(fontSize: 14.0.sp)),

          //! SPACER
          AppScreenUtils.verticalSpaceSmall,

          //! FROM TEXT FIELD
          AppTextFormField(controller: _fromController, hintText: "Monday")
        ])),

        //! SPACER
        AppScreenUtils.horizontalSpaceMedium,

        //! TO
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //! DOB
          Text(AppTexts.to,
              style: textTheme.bodyLarge!.copyWith(fontSize: 14.0.sp)),

          //! SPACER
          AppScreenUtils.verticalSpaceSmall,

          //! SEX TEXT FIELD
          AppTextFormField(controller: _toController, hintText: "Thursday")
        ]))
      ]),

      //! SPACER
      AppScreenUtils.verticalSpaceMedium,

      //! DRIVER ID
      Text(AppTexts.driversID,
          style: textTheme.bodyLarge!.copyWith(fontSize: 14.0.sp)),

      //!
      //! DRIVERS ID
      Row(children: [
        Container(
            padding: EdgeInsets.all(12.0.sp),
            decoration: BoxDecoration(
                color: AppThemeColours.appBlueTransparent,
                borderRadius: BorderRadius.circular(5.0.r),
                border:
                    Border.all(width: 0.8.sp, color: AppThemeColours.appBlue)),
            child: Text(AppTexts.generateID,
                style: textTheme.bodyLarge!.copyWith(
                    fontSize: 12.0.sp, color: AppThemeColours.appBlue))),

        //! SPACER
        AppScreenUtils.horizontalSpaceMedium,

        //! PHONE NUMBER
        Expanded(
            child: AppTextFormField(
                controller: _amountToBePaidController, hintText: "0 0 0 0"))
      ]),

      //! SPACER
      AppScreenUtils.verticalSpaceMedium,

      //! UPLOAD BUTTON
      AppElevatedButton(
          child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppThemeColours.appGreen),
              child: const Text(AppTexts.done)))
    ]);
  }
}
