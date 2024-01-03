import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urban_transit_admin/shared/utils/app_images.dart';
import 'package:urban_transit_admin/shared/utils/app_screen_utils.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class SenderMessageCard extends StatelessWidget {
  const SenderMessageCard({
    Key? key,
    required this.message,
    required this.date,
    this.isNotificationScreen,
  }) : super(key: key);
  final String message;
  final String date;
  final bool? isNotificationScreen;

  @override
  Widget build(BuildContext context) => Align(
      alignment: Alignment.centerLeft,
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        //! UER IMAGE
        //! UER IMAGE
        isNotificationScreen != null && isNotificationScreen == true
            ? CircleAvatar(
                radius: 18.0.r,
                backgroundColor: AppThemeColours.appBlueTransparent,
                child: CircleAvatar(
                  radius: 16.0.r,
                  backgroundColor: AppThemeColours.appBlue,
                  backgroundImage: const AssetImage(AppImages.user2),
                ),
              )
            :
            //! OTHER SCREENS
            CircleAvatar(
                radius: 14.0.r,
                backgroundColor: AppThemeColours.appBlueTransparent,
                child: CircleAvatar(
                  radius: 12.0.r,
                  backgroundColor: AppThemeColours.appBlue,
                  backgroundImage: const AssetImage(AppImages.user2),
                ),
              ),

        //! MAIN MESSAGE
        isNotificationScreen != null && isNotificationScreen == true
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Wrap(
                      children: [
                        Container(
                            width: 450.0.w,
                            padding: AppScreenUtils.notificationChatPadding,
                            margin: EdgeInsets.symmetric(horizontal: 8.0.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0.r),
                                color: AppThemeColours.appBlueTransparent),
                            child: Text(message,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.justify,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: AppThemeColours.black,
                                        fontSize: 16.0.sp))),
                      ],
                    ),

                    //! DATE
                    Padding(
                        padding: AppScreenUtils.notificationChatPadding,
                        child: Text(date,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 14.0.sp)))
                  ])
            :

            //! OTHER SCREENS
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                    width: 300.0.w,
                    padding: AppScreenUtils.notificationChatPadding,
                    margin: EdgeInsets.symmetric(horizontal: 8.0.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0.r),
                        color: AppThemeColours.appBlueTransparent),
                    child: Text(message,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.justify,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppThemeColours.black, fontSize: 14.0.sp))),

                //! DATE
                Padding(
                    padding: AppScreenUtils.notificationChatPadding,
                    child: Text(date,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 12.0.sp)))
              ])
      ]));
}
