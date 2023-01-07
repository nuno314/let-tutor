part of 'meeting_screen.dart';

extension MeetingAction on _MeetingScreenState {
  void _blocListener(BuildContext context, MeetingState state) {}

  _joinMeeting() async {
    String? serverUrl = 'https://meet.lettutor.com';
    String room =
        JwtDecoder.decode(bloc.state.info!.studentMeetingLink!)['room'];

    print(room);

    // Enable or disable any feature flag here
    // If feature flag are not provided, default values will be used
    // Full list of feature flags (and defaults) available in the README
    Map<FeatureFlagEnum, bool> featureFlags = {
      FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
    };
    // Disable ConnectionService usage on Android to avoid issues (see README)
    featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
    // Define meetings options here
    var options = JitsiMeetingOptions(room: room)
      ..serverURL = serverUrl
      ..subject = tutor?.name
      ..userDisplayName = injector.get<AppApiService>().currentUser?.name
      ..userEmail = injector.get<AppApiService>().currentUser?.email
      ..iosAppBarRGBAColor = iosAppBarRGBAColor.text
      ..audioOnly = isAudioOnly
      ..audioMuted = isAudioMuted
      ..videoMuted = isVideoMuted
      ..featureFlags.addAll(featureFlags)
      ..userAvatarURL = injector.get<AppApiService>().currentUser?.email
      ..webOptions = {
        "roomName": tutor?.name,
        "width": "100%",
        "height": "100%",
        "enableWelcomePage": false,
        "chromeExtensionBanner": null,
        "userInfo": {
          "displayName": injector.get<AppApiService>().currentUser?.name
        }
      };

    debugPrint("JitsiMeetingOptions: $options");
    await JitsiMeet.joinMeeting(
      options,
      listener: JitsiMeetingListener(
          onConferenceWillJoin: (message) {
            debugPrint("${options.room} will join with message: $message");
          },
          onConferenceJoined: (message) {
            debugPrint("${options.room} joined with message: $message");
          },
          onConferenceTerminated: (message) {
            debugPrint("${options.room} terminated with message: $message");
          },
          genericListeners: [
            JitsiGenericListener(
                eventName: 'readyToClose',
                callback: (dynamic message) {
                  debugPrint("readyToClose callback");
                }),
          ]),
    );
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
