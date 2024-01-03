import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urban_transit_admin/shared/utils/app_images.dart';
import 'package:urban_transit_admin/shared/utils/app_screen_utils.dart';
import 'package:urban_transit_admin/shared/utils/app_texts.dart';
import 'package:urban_transit_admin/shared/utils/profile_image.dart';
import 'package:urban_transit_admin/screens/widgets/messaging_text_form_field.dart';
import 'package:urban_transit_admin/screens/dashboard/messaging/widget/message_list.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class NotificationChatView extends StatefulWidget {
  const NotificationChatView({
    super.key,
  });

  @override
  State<NotificationChatView> createState() => _NotificationChatViewState();
}

class _NotificationChatViewState extends State<NotificationChatView> {
  late TextEditingController _messageEditingController;

  @override
  void initState() {
    super.initState();
    _messageEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _messageEditingController.clear();
    _messageEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //! TEXT STYLE
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(children: [
      //! HEADER
      MessagingHeader(
        imageURL: "",
        fullName: "Micheal GotDamn",
        contact: "#64538252423",
        isOnline: true,
        isVerified: true,
        callUser: () {},
      ),

      //! SPACER
      AppScreenUtils.verticalSpaceMedium,

      //! DATE AND TIME
      Text("Wednesday 23rd May,2022",
          style: textTheme.bodyLarge!.copyWith(fontSize: 12.0.sp)),

      //! SPACER
      AppScreenUtils.verticalSpaceMedium,

      //! MAIN MESSAGES
      const Expanded(child: MessageList(isNotificationScreen: true)),

      //! DIVIDER
      SizedBox(
        height: 1.0.h,
        child: Divider(
            height: 1.0.h,
            thickness: 0.8.sp,
            color: AppThemeColours.appGreyBGColour),
      ),

      //! SPACER
      AppScreenUtils.verticalSpaceSmall,

      //! BASE - TEXT FORM FIELD AND MIC ICON
      Row(children: [
        Expanded(
          child: MessagingTextFormField(
              controller: _messageEditingController,
              suffixIcon: Icons.send_outlined,
              hintText: AppTexts.writeAMessage,
              suffixIconColour: AppThemeColours.appBlue),
        ),

        //! SPACER
        AppScreenUtils.horizontalSpaceSmall,

        //! MIC
        InkWell(
          onTap: () {},
          child: CircleAvatar(
            radius: 16.0.r,
            backgroundColor: AppThemeColours.appBlue,
            child: Icon(Icons.mic_outlined,
                size: 16.0.sp, color: AppThemeColours.appWhiteBGColour),
          ),
        )
      ])
    ]);
  }
}

//!
//!
//! MESSAGE HEADER SHOWING USER NAME, PHONE NUMBER, PROFILE PHOTO
class MessagingHeader extends StatelessWidget {
  final String imageURL;
  final String fullName;
  final String contact;
  final bool isOnline;
  final bool isVerified;
  final bool? isNotificationScreen;
  final void Function() callUser;
  const MessagingHeader(
      {super.key,
      required this.imageURL,
      required this.fullName,
      required this.contact,
      required this.isOnline,
      required this.callUser,
      required this.isVerified,
      this.isNotificationScreen});

  @override
  Widget build(BuildContext context) {
    //! TEXT STYLE
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(children: [
      //! IMAGE
      const ProfilePhotoWidget(imageURL: AppImages.user2),

      //! SPACER
      AppScreenUtils.horizontalSpaceSmall,

      //! HEADER DETAILS
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(fullName,
            style: textTheme.bodyLarge!.copyWith(
                fontSize: isNotificationScreen != null ? 18.0.sp : 14.0.sp)),

        //! CONTACT / IS ONLINE
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(contact,
              style: textTheme.bodyMedium!.copyWith(fontSize: 12.0.sp)),

          //! SPACER
          AppScreenUtils.horizontalSpaceSmall,

          Text(isOnline ? "Online" : "Offline",
              style: textTheme.bodyMedium!
                  .copyWith(fontSize: 12.0.sp, color: AppThemeColours.appGreen))
        ])
      ]),

      //! SPACER
      const Spacer(),

      //! CALL ICON
      InkWell(
          onTap: () => callUser(),
          child: Container(
              padding: EdgeInsets.all(10.0.sp),
              decoration: BoxDecoration(
                  color: AppThemeColours.appBlueTransparent,
                  borderRadius: BorderRadius.circular(8.0.r)),
              child: Icon(Icons.call,
                  size: 16.0.sp, color: AppThemeColours.appBlue)))
    ]);
  }
}
