import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum VoiceRecorderStates { notRecording, recording, recordingPaused, recorded }

final voiceMessageController =
    AsyncNotifierProvider<VoiceMessageController, VoiceRecorderStates>(
  VoiceMessageController.new,
);

class VoiceMessageController extends AsyncNotifier<VoiceRecorderStates> {
  //!
  @override
  FutureOr<VoiceRecorderStates> build() => VoiceRecorderStates.notRecording;

  void isRecording({required VoiceRecorderStates isRecording}) =>
      state = AsyncValue.data(isRecording);
}

//!
//! RECORDED VOICE MESSAGE
final recordedVoiceMessageController =
    AsyncNotifierProvider<RecordedVoiceMessageController, String>(
  RecordedVoiceMessageController.new,
);

class RecordedVoiceMessageController extends AsyncNotifier<String> {
  //!
  @override
  FutureOr<String> build() => "";

  void isVoiceMessageRecorded({required String recordedMessageURL}) =>
      state = AsyncValue.data(recordedMessageURL);
}

//!
//! VOICE MESSAGE PLAYER CONTROLLER
final voiceMessagePlayerController =
    AsyncNotifierProvider<VoiceMessagePlayerController, PlayerState>(
  VoiceMessagePlayerController.new,
);

class VoiceMessagePlayerController extends AsyncNotifier<PlayerState> {
  //!
  @override
  FutureOr<PlayerState> build() => PlayerState.stopped;

  void updateThePlayingState({required PlayerState playingState}) =>
      state = AsyncValue.data(playingState);
}
