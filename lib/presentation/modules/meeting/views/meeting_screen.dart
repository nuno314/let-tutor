import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:let_tutor/common/utils.dart';
import 'package:let_tutor/data/data_source/remote/app_api_service.dart';
import 'package:let_tutor/data/models/teacher.dart';
import 'package:let_tutor/di/di.dart';
import 'package:let_tutor/presentation/common_widget/export.dart';
import 'package:let_tutor/presentation/theme/shadow.dart';
import 'package:let_tutor/presentation/theme/theme_button.dart';

import '../../../base/base.dart';
import '../../../extentions/extention.dart';
import '../../../theme/theme_color.dart';
import '../bloc/meeting_bloc.dart';

part 'meeting.action.dart';

class MeetingScreen extends StatefulWidget {
  const MeetingScreen({Key? key}) : super(key: key);

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends StateBase<MeetingScreen> {
  @override
  MeetingBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  late AppLocalizations trans;

  final iosAppBarRGBAColor =
      TextEditingController(text: "#0080FF80"); //transparent blue
  bool isAudioOnly = true;
  bool isAudioMuted = true;
  bool isVideoMuted = true;

  Teacher? get tutor => bloc.state.info?.schedule?.scheduleInfo?.tutorInfo;

  @override
  void initState() {
    super.initState();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    trans = translate(context);
    return BlocConsumer<MeetingBloc, MeetingState>(
      listener: _blocListener,
      builder: (context, state) {
        return ScreenForm(
          headerColor: AppColor.primaryColor,
          bgColor: AppColor.scaffoldColor,
          showHeaderImage: false,
          trans: trans,
          title: trans.goToMeeting,
          child: meetConfig(state),
        );
      },
    );
  }

  Widget meetConfig(MeetingState state) {
    if (state.info == null) {
      return Loading();
    }
    final info = state.info!;
    final infos = [
      {trans.tutor: tutor?.name ?? '--'},
      {
        trans.startTime: DateTime.fromMillisecondsSinceEpoch(
          info.schedule!.startPeriodTimestamp ?? 0,
        ).toLocal().toTimeFormat()
      },
      {
        trans.endTime: DateTime.fromMillisecondsSinceEpoch(
          info.schedule!.endPeriodTimestamp ?? 0,
        ).toLocal().toTimeFormat()
      },
    ];
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 32,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              boxShadow: boxShadowDark,
              color: AppColor.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: tutor?.isOnline == true
                          ? AppColor.primaryColor
                          : AppColor.gray8C,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImageWrapper.avatar(
                      url: tutor?.avatar ?? '',
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          trans.lessonInfo,
                          style: textTheme.bodyLarge,
                        ),
                        Divider(
                          height: 24,
                          thickness: 2,
                          endIndent: 4,
                          color: AppColor.gray8C,
                        ),
                        ...infos.map((e) => Row(
                              children: [
                                const SizedBox(width: 4),
                                Text(
                                  e.keys.first,
                                  style: textTheme.bodyMedium?.copyWith(
                                    fontSize: 14,
                                    color: AppColor.gray8C,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  e.values.first,
                                  style: textTheme.bodyMedium
                                      ?.copyWith(fontSize: 14),
                                ),
                                const SizedBox(width: 4),
                              ],
                            )),
                      ]),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 14.0,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              boxShadow: boxShadowlight,
              color: AppColor.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    isVideoMuted ? Icons.videocam : Icons.videocam_off,
                    color: isVideoMuted ? AppColor.primaryColor : AppColor.red,
                  ),
                  onPressed: () {
                    setState(() {
                      _onVideoMutedChanged(!isVideoMuted);
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    isAudioMuted ? Icons.volume_up : Icons.volume_off,
                    color: isAudioMuted ? AppColor.primaryColor : AppColor.red,
                  ),
                  onPressed: () {
                    setState(() {
                      _onAudioMutedChanged(!isAudioMuted);
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    isAudioOnly ? Icons.mic : Icons.mic_off,
                    color: isAudioOnly ? AppColor.primaryColor : AppColor.red,
                  ),
                  onPressed: () {
                    setState(() {
                      _onAudioOnlyChanged(!isAudioOnly);
                    });
                  },
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 290,
            alignment: Alignment.bottomCenter,
            child: ThemeButton.primaryIcon(
              context: context,
              title: trans.goToMeeting,
              icon: Icon(
                Icons.phone,
                color: AppColor.white,
              ),
              onPressed: () async {
                await _joinMeeting();
              },
              bgColor: AppColor.green,
            ),
          ),
        ],
      ),
    );
  }

  _onAudioOnlyChanged(bool? value) {
    setState(() {
      isAudioOnly = value ?? false;
    });
  }

  _onAudioMutedChanged(bool? value) {
    setState(() {
      isAudioMuted = value ?? false;
    });
  }

  _onVideoMutedChanged(bool? value) {
    setState(() {
      isVideoMuted = value ?? false;
    });
  }
}
