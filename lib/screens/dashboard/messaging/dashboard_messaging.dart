import 'package:audioplayers/audioplayers.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound_record/flutter_sound_record.dart';
import 'package:urban_transit_admin/screens/widgets/call_dialogue.dart';
import 'package:urban_transit_admin/services/controllers/voice_message_recorder_controller.dart';
import 'package:urban_transit_admin/shared/utils/app_extensions.dart';
import 'package:urban_transit_admin/shared/utils/app_images.dart';
import 'package:urban_transit_admin/shared/utils/app_screen_utils.dart';
import 'package:urban_transit_admin/shared/utils/app_texts.dart';
import 'package:urban_transit_admin/shared/utils/profile_image.dart';
import 'package:urban_transit_admin/screens/widgets/messaging_text_form_field.dart';
import 'package:urban_transit_admin/screens/dashboard/messaging/widget/message_list.dart';
import 'package:urban_transit_admin/theme/theme.dart';

class DashboardMessaging extends ConsumerStatefulWidget {
  final void Function() onTap;
  const DashboardMessaging({
    super.key,
    required this.onTap,
  });

  @override
  ConsumerState<DashboardMessaging> createState() => _DashboardMessagingState();
}

class _DashboardMessagingState extends ConsumerState<DashboardMessaging> {
  late TextEditingController _messageEditingController;
  final player = AudioPlayer();
  final recorder = FlutterSoundRecord();

  @override
  void initState() {
    super.initState();
    _messageEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _messageEditingController.clear();
    _messageEditingController.dispose();
    recorder.dispose();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //! TEXT STYLE
    final TextTheme textTheme = Theme.of(context).textTheme;
    final isVoiceRecording = ref.watch(voiceMessageController);
    final theRecordedMessageURL = ref.watch(recordedVoiceMessageController);

    return Column(children: [
      //! HEADER
      MessagingHeader(
        imageURL: "",
        fullName: "Micheal GotDamn",
        contact: "#64538252423",
        isOnline: true,
        isVerified: true,
        //!TODO: FIX BELOW
        callUser: () => AppScreenUtils.showAppCallDialogue(
          theBuildContext: context,
          width: 350.0.w,
          height: 500.0.h,
          child: CallDialogue(
            minimize: () {},
            maximize: () {},
            close: () => Navigator.of(context).pop(),
          ),
        ),
        onTap: widget.onTap,
      ),

      //! SPACER
      AppScreenUtils.verticalSpaceSmall,

      //! DIVIDER
      SizedBox(
          height: 1.0.h,
          child: Divider(
              height: 1.0.h,
              thickness: 0.8.sp,
              color: AppThemeColours.appGreyBGColour)),

      //! SPACER
      AppScreenUtils.verticalSpaceSmall,

      //! DATE AND TIME
      Text("Wednesday 23rd May,2022",
          style: textTheme.bodyLarge!.copyWith(fontSize: 12.0.sp)),

      //! SPACER
      AppScreenUtils.verticalSpaceSmall,

      //! MAIN MESSAGES
      const Expanded(child: MessageList()),

      //! DIVIDER
      SizedBox(
          height: 1.0.h,
          child: Divider(
              height: 1.0.h,
              thickness: 0.8.sp,
              color: AppThemeColours.appGreyBGColour)),

      //! SPACER
      AppScreenUtils.verticalSpaceSmall,

      //! BASE - TEXT FORM FIELD AND MIC ICON
      Row(children: [
        Expanded(
            child: MessagingTextFormField(
                controller: _messageEditingController,
                suffixIcon: Icons.send_outlined,
                hintText: AppTexts.writeAMessage,
                suffixIconColour: AppThemeColours.appBlue)),

        //! SPACER
        AppScreenUtils.horizontalSpaceSmall,

        //! MIC
        isVoiceRecording.when(
          data: (recorderState) {
            return recorderState == VoiceRecorderStates.notRecording
                ? CircleAvatar(
                    radius: 16.0.r,
                    backgroundColor: AppThemeColours.appBlue,
                    child: Icon(Icons.mic_outlined,
                        size: 16.0.sp, color: AppThemeColours.appWhiteBGColour),
                  ).onTap(
                    onTap: () async {
                      ref.read(voiceMessageController.notifier).isRecording(
                          isRecording: VoiceRecorderStates.recording);

                      await recorder.start();
                    },
                  )
                : recorderState == VoiceRecorderStates.recorded
                    ? theRecordedMessageURL.when(
                        data: (recordedFilePath) {
                          return Row(
                            children: [
                              Icon(
                                Icons.play_arrow_outlined,
                                /* playingState == PlayerState.stopped
                                          ? Icons.play_arrow_outlined
                                          : Icons.pause_outlined, */
                                color: AppThemeColours.appBlue,
                                size: 18,
                              ).onTap(
                                onTap: () async {
                                  player.state.log();
                                  if (recordedFilePath.isEmpty) {
                                    await player
                                        .play(UrlSource(recordedFilePath));
                                  }

                                  /* if (playingState ==
                                            PlayerState.stopped) {
                                        } else if (playingState ==
                                            PlayerState.playing) {
                                          await player.stop();
                                          ref
                                              .read(voiceMessagePlayerController
                                                  .notifier)
                                              .updateThePlayingState(
                                                  playingState:
                                                      PlayerState.stopped);
                                        } */
                                },
                              ),
                              /* Builder(builder: (context) {
                                final isPlaying =
                                    ref.watch(voiceMessagePlayerController);

                                return isPlaying.when(
                                  data: (playingState) {
                                    return Icon(
                                      playingState == PlayerState.stopped
                                          ? Icons.play_arrow_outlined
                                          : Icons.pause_outlined,
                                      color: AppThemeColours.appBlue,
                                      size: 18,
                                    ).onTap(
                                      onTap: () async {
                                        player.state.log();
                                        if (recordedFilePath.isEmpty) {
                                          await player.play(
                                              UrlSource(recordedFilePath));
                                        }

                                        /* if (playingState ==
                                            PlayerState.stopped) {
                                        } else if (playingState ==
                                            PlayerState.playing) {
                                          await player.stop();
                                          ref
                                              .read(voiceMessagePlayerController
                                                  .notifier)
                                              .updateThePlayingState(
                                                  playingState:
                                                      PlayerState.stopped);
                                        } */
                                      },
                                    );
                                  },
                                  error: (error, stackTrace) =>
                                      "$error $stackTrace".txt(),
                                  loading: () =>
                                      const CircularProgressIndicator(),
                                );
                              }), */
                              12.0.sizedBoxWidth,
                              const Icon(
                                Icons.delete_outline,
                                color: AppThemeColours.appRed,
                                size: 18,
                              ).onTap(
                                onTap: () async {
                                  ref
                                      .read(recordedVoiceMessageController
                                          .notifier)
                                      .isVoiceMessageRecorded(
                                          recordedMessageURL: "");

                                  ref
                                      .read(voiceMessageController.notifier)
                                      .isRecording(
                                          isRecording:
                                              VoiceRecorderStates.notRecording);
                                },
                              ),
                              12.0.sizedBoxWidth,
                              const Icon(
                                Icons.send_outlined,
                                color: AppThemeColours.appGreen,
                                size: 18,
                              ).onTap(
                                onTap: () async {
                                  ref
                                      .read(recordedVoiceMessageController
                                          .notifier)
                                      .isVoiceMessageRecorded(
                                          recordedMessageURL: "");

                                  ref
                                      .read(voiceMessageController.notifier)
                                      .isRecording(
                                          isRecording:
                                              VoiceRecorderStates.notRecording);
                                },
                              ),
                              12.0.sizedBoxWidth,
                            ],
                          );
                        },
                        error: (error, stackTrace) =>
                            "$error $stackTrace".txt(),
                        loading: () => const CircularProgressIndicator())
                    : CircleAvatar(
                        radius: 16.0.r,
                        backgroundColor: AppThemeColours.appGreenTransparent,
                        child: AvatarGlow(
                          endRadius: 120,
                          showTwoGlows: true,
                          duration: const Duration(seconds: 2),
                          glowColor: AppThemeColours.appGreen,
                          child: Icon(
                            Icons.send_outlined,
                            size: 16.0.sp,
                            color: AppThemeColours.appGreen,
                          ),
                        ),
                      ).onTap(
                        onTap: () async {
                          if (await recorder.isRecording()) {
                            String? recordedMessageURL = await recorder.stop();

                            if (recordedMessageURL != null) {
                              ref
                                  .read(recordedVoiceMessageController.notifier)
                                  .isVoiceMessageRecorded(
                                      recordedMessageURL: recordedMessageURL);
                            }

                            ref
                                .read(voiceMessageController.notifier)
                                .isRecording(
                                    isRecording: VoiceRecorderStates.recorded);
                          }
                        },
                      );
          },
          error: (error, stackTrace) => "$error $stackTrace".txt(),
          loading: () => const CircularProgressIndicator(),
        ),
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
  final void Function() callUser;
  final void Function() onTap;
  const MessagingHeader({
    super.key,
    required this.imageURL,
    required this.fullName,
    required this.contact,
    required this.isOnline,
    required this.callUser,
    required this.isVerified,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    //! TEXT STYLE
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Row(children: [
      const Icon(
        Icons.arrow_back_ios,
        color: AppThemeColours.appBlue,
        size: 18.0,
      ).onTap(
        onTap: onTap,
      ),

      12.0.sizedBoxWidth,

      //! IMAGE
      const ProfilePhotoWidget(imageURL: AppImages.dashboard),

      //! SPACER
      AppScreenUtils.horizontalSpaceSmall,

      //! HEADER DETAILS
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(fullName, style: textTheme.bodyLarge!.copyWith(fontSize: 14.0.sp)),

        //! CONTACT / IS ONLINE
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(contact,
                style: textTheme.bodyMedium!.copyWith(fontSize: 12.0.sp)),

            //! SPACER
            AppScreenUtils.horizontalSpaceSmall,

            Text(isOnline ? "Online" : "Offline",
                style: textTheme.bodyMedium!.copyWith(
                    fontSize: 12.0.sp, color: AppThemeColours.appGreen))
          ],
        )
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
