import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urban_transit_admin/shared/utils/app_screen_utils.dart';
import 'package:urban_transit_admin/shared/utils/app_texts.dart';
import 'package:urban_transit_admin/screens/widgets/app_elevated_button.dart';
import 'package:urban_transit_admin/screens/widgets/app_text_form_field.dart';
import 'package:urban_transit_admin/screens/drivers/widget/add_payment_options.dart';
import 'package:urban_transit_admin/screens/drivers/widget/assign_bus.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class AddDriver extends StatefulWidget {
  const AddDriver({super.key});

  @override
  State<AddDriver> createState() => _AddDriverState();
}

class _AddDriverState extends State<AddDriver> with TickerProviderStateMixin {
  //! ADD DRIVER OPTIONS
  late TabController _tabController;

  static const List<String> _addDriverOptions = [
    "Driver Information",
    "Payment Options",
    "Assign Bus"
  ];

  @override
  void initState() {
    super.initState();

    _tabController =
        TabController(length: _addDriverOptions.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    //! TEXT STYLE
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(children: [
      //! REMOVE SCREEN
      Row(children: [
        //! BACK
        IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios,
                size: 21.0.sp, color: AppThemeColours.appBlue)),

        //! SPACER
        AppScreenUtils.horizontalSpaceMedium,

        Text(AppTexts.addDriver,
            style: textTheme.bodyLarge!.copyWith(height: 1.2.sp))
      ]),

      //! SPACER
      AppScreenUtils.verticalSpaceMedium,

      //! TABS
      SizedBox(
          height: 50.0.h,
          width: double.infinity.w,
          child: //! TAB NOTIFIER
              TabBar(
                  controller: _tabController,
                  indicatorColor: AppThemeColours.primaryColour,
                  indicatorWeight: 1.5.h,
                  physics: const BouncingScrollPhysics(),
                  onTap: (value) {},
                  tabs: _addDriverOptions
                      .map((themeOption) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(themeOption,
                              style: textTheme.bodyLarge!
                                  .copyWith(fontSize: 12.0.sp))))
                      .toList())),

      //! SPACER
      AppScreenUtils.verticalSpaceMedium,

      //! TAB BAR VIEW
      SizedBox(
          height: 913.0.h,
          child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                //! FIRST PAGE -  DRIVER INFORMATION
                AddDriverWidget(),

                //! SECOND PAGE - PAYMENT OPTIONS
                AddPaymentOptions(),

                //! LAST PAGE - ASSIGN BUS
                AssignBus()
              ]))
    ]);
  }
}

//!
//!
//! ADD DRIVER
class AddDriverWidget extends StatelessWidget {
  AddDriverWidget({super.key});
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _homeAddressController = TextEditingController();
  final TextEditingController _ninController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //! TEXT STYLE
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //! FULL NAME
          Text(AppTexts.fullName,
              style: textTheme.bodyLarge!.copyWith(fontSize: 14.0.sp)),

          //! SPACER
          AppScreenUtils.verticalSpaceSmall,

          //! FULL NAME TEXT FIELD
          AppTextFormField(
              controller: _fullNameController, hintText: "Jones Micheal Favor"),

          //! SPACER
          AppScreenUtils.verticalSpaceMedium,

          //! OTHERS - SEX AND DOB
          Row(children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  //! SEX
                  Text(AppTexts.sex,
                      style: textTheme.bodyLarge!.copyWith(fontSize: 14.0.sp)),

                  //! SPACER
                  AppScreenUtils.verticalSpaceSmall,

                  //! SEX TEXT FIELD
                  AppTextFormField(controller: _sexController, hintText: "Male")
                ])),

            //! SPACER
            AppScreenUtils.horizontalSpaceMedium,

            //! DOB
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  //! DOB
                  Text(AppTexts.dateOfBirth,
                      style: textTheme.bodyLarge!.copyWith(fontSize: 14.0.sp)),

                  //! SPACER
                  AppScreenUtils.verticalSpaceSmall,

                  //! SEX TEXT FIELD
                  AppTextFormField(
                      controller: _dobController, hintText: "24/05/2022")
                ]))
          ]),

          //! SPACER
          AppScreenUtils.verticalSpaceMedium,

          //! OTHERS - EMAIL && PHONE NUMBER
          Row(children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  //! EMAIL
                  Text(AppTexts.email,
                      style: textTheme.bodyLarge!.copyWith(fontSize: 14.0.sp)),

                  //! SPACER
                  AppScreenUtils.verticalSpaceSmall,

                  //! SEX TEXT FIELD
                  AppTextFormField(
                      controller: _emailController,
                      hintText: "jonesmicheal@gmail.com")
                ])),

            //! SPACER
            AppScreenUtils.horizontalSpaceMedium,

            //! PHONE NUMBER
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  //! DOB
                  Text(AppTexts.phoneNumber,
                      style: textTheme.bodyLarge!.copyWith(fontSize: 14.0.sp)),

                  //! SPACER
                  AppScreenUtils.verticalSpaceSmall,

                  //! PHONE NUMBER TEXT FIELD
                  AppTextFormField(
                      controller: _phoneNumberController,
                      hintText: "08103344565")
                ]))
          ]),

          //! SPACER
          AppScreenUtils.verticalSpaceMedium,

          //! OTHERS - HOME ADDRESS && NIN
          Row(children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  //! HOME ADDRESS
                  Text(AppTexts.homeAddress,
                      style: textTheme.bodyLarge!.copyWith(fontSize: 14.0.sp)),

                  //! SPACER
                  AppScreenUtils.verticalSpaceSmall,

                  //! HOME ADDRESS TEXT FIELD
                  AppTextFormField(
                      controller: _homeAddressController,
                      hintText: " No 23, Allen Jones Avenue Ikeja Lagos")
                ])),

            //! SPACER
            AppScreenUtils.horizontalSpaceMedium,

            //! NIN
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  //! NIN
                  Text(AppTexts.nin,
                      style: textTheme.bodyLarge!.copyWith(fontSize: 14.0.sp)),

                  //! SPACER
                  AppScreenUtils.verticalSpaceSmall,

                  //! NIN TEXT FIELD
                  AppTextFormField(
                      controller: _ninController, hintText: "1183672266345")
                ]))
          ]),

          //! SPACER
          AppScreenUtils.verticalSpaceMedium,

          //! UPLOAD DOCUMENT SECTION
          Center(
              child: Container(
                  width: 459.0.w,
                  height: 181.0.h,
                  decoration: BoxDecoration(
                      color: AppThemeColours.appGreyBGColour.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(5.0.r)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //! ICON
                        Icon(Icons.cloud_upload_outlined,
                            size: 32.0.sp, color: AppThemeColours.appGreen),

                        Text(AppTexts.uploadFileNotice,
                            style: textTheme.bodyLarge!
                                .copyWith(fontSize: 14.0.sp))
                      ]))),

          //! SPACER
          AppScreenUtils.verticalSpaceSmall,

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
