part of 'meeting_screen.dart';

extension MeetingAction on _MeetingScreenState {
  void _blocListener(BuildContext context, MeetingState state) {}

  _joinMeeting() async {
    try {
      if (bloc.state.info!.studentMeetingLink == null) return;
      final student = injector.get<AppApiService>().currentUser!;
      String token = bloc.state.info!.studentMeetingLink!.split('token=').last;
      Map<String, dynamic> payload = Jwt.parseJwt(token);
      String room = payload['room'];

      var options = JitsiMeetingOptions(room: room)
        ..serverURL = 'https://meet.lettutor.com'
        ..token = token
        ..subject = tutor?.name ?? ''
        ..userDisplayName = student.name
        ..userEmail = student.email
        ..userAvatarURL = student.avatar
        ..audioOnly = isAudioOnly
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted
        ..featureFlags = {
          FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
        };
      LogUtils.e('$options.toString()');

      final response = await JitsiMeet.joinMeeting(options);
      LogUtils.d('JitsiMeetHelper -> joinMeeting() -> Response: $response');
      if (!response.isSuccess) {
        LogUtils.d('Fail');
      }
    } catch (e) {
      LogUtils.e('JitsiMeetHelper -> joinMeeting()', '$e');
    }
  }

  void _onConferenceWillJoin(message) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined(message) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated(message) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }
}
