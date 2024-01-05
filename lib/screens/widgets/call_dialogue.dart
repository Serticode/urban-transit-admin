import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:urban_transit_admin/shared/utils/app_extensions.dart';
import 'package:urban_transit_admin/shared/utils/app_screen_utils.dart';
import 'package:urban_transit_admin/shared/utils/app_texts.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class CallDialogue extends ConsumerWidget {
  final void Function() minimize;
  final void Function() maximize;
  final void Function() close;
  final double? height;
  final String? driverName;
  final bool? isCalling;
  final bool? isCallActive;
  const CallDialogue(
      {super.key,
      required this.minimize,
      required this.maximize,
      required this.close,
      this.driverName,
      this.isCalling,
      this.isCallActive,
      this.height});
  //! DEFINITIONS
  static const List<IconData> menuIcons = [Icons.remove, Icons.close];

  static final List<Color> menuIconColours = [
    Colors.grey.shade800,
    AppThemeColours.appRed
  ];

  static const List<Color> menuIconBGColour = [
    AppThemeColours.appGreyBGColour,
    AppThemeColours.appRedTransparent
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //! TEXT STYLE
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Row(
            children: [
              //! TITLE
              Text(AppTexts.call,
                  style: textTheme.displayLarge!.copyWith(fontSize: 24.0.sp)),

              //! SPACER
              const Spacer(),

              //! BUTTONS - MINIMIZE
              ...menuIcons.map(
                (icon) => Padding(
                  padding: EdgeInsets.only(
                      right: menuIcons.indexOf(icon) == menuIcons.length - 1
                          ? 0.0.sp
                          : 12.0.sp),
                  child: InkWell(
                    onTap: () =>
                        menuIconOnTapTrigger(index: menuIcons.indexOf(icon)),
                    child: CircleAvatar(
                      radius: 14.0.r,
                      backgroundColor:
                          menuIconBGColour.elementAt(menuIcons.indexOf(icon)),
                      child: Icon(
                        icon,
                        size: 12.0.sp,
                        color: menuIconColours.elementAt(
                          menuIcons.indexOf(icon),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          //! SPACER
          AppScreenUtils.verticalSpaceMedium,

          //! CALL TITLE
          const CallTitle(),

          //! SPACER
          AppScreenUtils.verticalSpaceLarge,

          //! USER PROFILE PICTURE
          Container(
            padding: AppScreenUtils.containerPaddingTiny,
            height: 120.0.h,
            width: 100.0.w,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppThemeColours.appBlueTransparent),
            child: const CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage:
                  AssetImage("lib/assets/images/urbantransit_logo.jpg"),
            ),
          ),

          //! SPACER
          AppScreenUtils.verticalSpaceLarge,

          //! CALL TO ACTION
          CallCTA(
            onSpeakerPressed: () {},
            onEndCallPressed: () {},
            onMute: () {},
          )
        ]));
  }

  void menuIconOnTapTrigger({required int index}) {
    switch (index) {
      case 0:
        minimize();
        break;
      case 1:
        close();
        break;
      default:
    }
  }
}

class CallTitle extends ConsumerWidget {
  final String? calledUserName;
  const CallTitle({this.calledUserName, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //! TEXT STYLE
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        //! SPACER
        const Spacer(),

        //! TITLE
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //! NAME
            Text(calledUserName ?? "Micheal GotDamn",
                style: textTheme.bodyLarge!.copyWith(
                    color: AppThemeColours.bodyText1TextColour,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0.sp)),

            //! IS CALLING
            Text(
              "Calling...",
              style: textTheme.bodyMedium!.copyWith(
                color: AppThemeColours.appGreen,
                fontSize: 12.0.sp,
              ),
            ),
          ],
        ),

        //! SPACER
        const Spacer(),

        //! MESSAGE ICON
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 40.0.h,
            width: 40.0.w,
            //padding: AppScreenUtils.containerPaddingTiny,
            decoration: BoxDecoration(
              color: AppThemeColours.appBlueTransparent,
              borderRadius: BorderRadius.circular(10.0.r),
            ),
            child: const Icon(
              Icons.chat_outlined,
              color: AppThemeColours.appBlue,
            ).alignCenter(),
          ),
        ),
      ],
    );
  }
}

//!
//!
class CallCTA extends ConsumerWidget {
  final void Function() onSpeakerPressed;
  final void Function() onEndCallPressed;
  final void Function() onMute;
  final bool? isSpeakerActive;
  final bool? isMuteActive;
  const CallCTA({
    super.key,
    this.isSpeakerActive,
    this.isMuteActive,
    required this.onSpeakerPressed,
    required this.onEndCallPressed,
    required this.onMute,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      //! ICON BUTTON - SPEAKER
      IconButton(
        onPressed: () => onSpeakerPressed(),
        icon: Icon(
          Icons.volume_up_rounded,
          size: 16.0.sp,
          color: isSpeakerActive != null && isSpeakerActive == true
              ? AppThemeColours.appBlue
              : AppThemeColours.appGrey,
        ),
      ),

      //! SPACER
      AppScreenUtils.horizontalSpaceMedium,

      //! ICON BUTTON - SPEAKER
      CircleAvatar(
        radius: 21.0.r,
        backgroundColor: AppThemeColours.appBlueTransparent,
        child: IconButton(
          onPressed: () => onSpeakerPressed(),
          icon: Icon(Icons.volume_mute,
              size: 16.0.sp, color: AppThemeColours.appBlue),
        ),
      ),

      //! SPACER
      AppScreenUtils.horizontalSpaceMedium,

      //! ICON BUTTON - SPEAKER
      IconButton(
        onPressed: () => onSpeakerPressed(),
        icon: Icon(
          Icons.mic_off,
          size: 16.0.sp,
          color: isMuteActive != null && isMuteActive == true
              ? AppThemeColours.appBlue
              : AppThemeColours.appGrey,
        ),
      )
    ]);
  }
}
