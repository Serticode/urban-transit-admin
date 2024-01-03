import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urban_transit_admin/shared/utils/app_images.dart';
import 'package:urban_transit_admin/shared/utils/app_screen_utils.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class MyMessageCard extends StatelessWidget {
  final String message;
  final String date;
  final bool? isNotificationScreen;

  const MyMessageCard({
    Key? key,
    required this.message,
    required this.date,
    this.isNotificationScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //! MAIN MESSAGE
            isNotificationScreen != null && isNotificationScreen == true
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 450.0.w,
                        padding: AppScreenUtils.notificationChatPadding,
                        margin: EdgeInsets.symmetric(horizontal: 8.0.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0.r),
                          border: Border.all(
                              color: Colors.grey.shade500, width: 1.w),
                          color: AppThemeColours.backgroundColourGrey,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              blurRadius: 12.0.r,
                              spreadRadius: 6.0.r,
                              color: AppThemeColours.appGreyBGColour
                                  .withOpacity(0.5),
                            )
                          ],
                        ),
                        child: Wrap(
                          children: [
                            Text(
                              message,
                              overflow: TextOverflow.visible,
                              textAlign: TextAlign.justify,
                              softWrap: true,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: AppThemeColours.black,
                                      fontSize: 16.0.sp),
                            ),
                          ],
                        ),
                      ),

                      //! DATE
                      Padding(
                        padding: AppScreenUtils.notificationChatPadding,
                        child: Text(
                          date,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 14.0.sp),
                        ),
                      )
                    ],
                  )
                :

                //! OTHER SCREENS
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Container(
                      width: 300.0.w,
                      padding: AppScreenUtils.notificationChatPadding,
                      margin: EdgeInsets.symmetric(horizontal: 8.0.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0.r),
                          border: Border.all(
                              color: Colors.grey.shade500, width: 1.w),
                          color: AppThemeColours.backgroundColourGrey,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                blurRadius: 12.0.r,
                                spreadRadius: 6.0.r,
                                color: AppThemeColours.appGreyBGColour
                                    .withOpacity(0.5))
                          ]),
                      child: Wrap(
                        children: [
                          Text(
                            message,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.justify,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: AppThemeColours.black,
                                    fontSize: 14.0.sp),
                          ),
                        ],
                      ),
                    ),

                    //! DATE
                    Padding(
                      padding: AppScreenUtils.notificationChatPadding,
                      child: Text(
                        date,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 10.0.sp),
                      ),
                    )
                  ]),

            //! USER IMAGE
            isNotificationScreen != null && isNotificationScreen == true
                ? CircleAvatar(
                    radius: 18.0.r,
                    backgroundColor: AppThemeColours.appBlueTransparent,
                    child: CircleAvatar(
                      radius: 16.0.r,
                      backgroundColor: AppThemeColours.appBlue,
                      backgroundImage: const AssetImage(
                        AppImages.user1,
                      ),
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
          ],
        ),
      );
}
