import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urban_transit_admin/shared/utils/app_screen_utils.dart';
import 'package:urban_transit_admin/shared/utils/app_texts.dart';
import 'package:urban_transit_admin/screens/widgets/app_elevated_button.dart';
import 'package:urban_transit_admin/screens/widgets/app_text_form_field.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class AddPaymentOptions extends StatelessWidget {
  AddPaymentOptions({super.key});

  final TextEditingController _chooseBank = TextEditingController();
  final TextEditingController _accountNumber = TextEditingController();
  final TextEditingController _salaryOptions = TextEditingController();
  final TextEditingController _amountToBePaidController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    //! TEXT STYLE
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          //!
          //! OTHERS - CHOOSE BANK - ACCOUNT NUMBER
          Row(children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  //! CHOOSE BANK
                  Text(AppTexts.chooseBank,
                      style: textTheme.bodyLarge!.copyWith(fontSize: 14.0.sp)),

                  //! SPACER
                  AppScreenUtils.verticalSpaceSmall,

                  //! SEX TEXT FIELD
                  AppTextFormField(
                      controller: _chooseBank,
                      hintText: "United Bank Of Africa")
                ])),

            //! SPACER
            AppScreenUtils.horizontalSpaceMedium,

            //! ACCOUNT NUMBER
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  //! DOB
                  Text(AppTexts.accountNumber,
                      style: textTheme.bodyLarge!.copyWith(fontSize: 14.0.sp)),

                  //! SPACER
                  AppScreenUtils.verticalSpaceSmall,

                  //! SEX TEXT FIELD
                  AppTextFormField(
                      controller: _accountNumber, hintText: "00234758558")
                ]))
          ]),

          //! SPACER
          AppScreenUtils.verticalSpaceMedium,

          //!
          //! OTHERS - SALARY OPTIONS
          Row(children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  //! SALARY OPTIONS
                  Text(AppTexts.salaryOption,
                      style: textTheme.bodyLarge!.copyWith(fontSize: 14.0.sp)),

                  //! SPACER
                  AppScreenUtils.verticalSpaceSmall,

                  //! SEX TEXT FIELD
                  AppTextFormField(
                      controller: _salaryOptions, hintText: "Monthly")
                ])),

            //! SPACER
            AppScreenUtils.horizontalSpaceMedium,

            //! PHONE NUMBER
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  //! DOB
                  Text(AppTexts.amountToBePaid,
                      style: textTheme.bodyLarge!.copyWith(fontSize: 14.0.sp)),

                  //! SPACER
                  AppScreenUtils.verticalSpaceSmall,

                  //! AMOUNT TO BE PAID TEXT FIELD
                  AppTextFormField(
                      controller: _amountToBePaidController,
                      hintText: "30000.00")
                ]))
          ]),

          //! SPACER
          AppScreenUtils.verticalSpaceMedium,

          //! UPLOAD BUTTON
          AppElevatedButton(
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppThemeColours.appBlue),
                  child: const Text(AppTexts.next)))
        ]));
  }
}
