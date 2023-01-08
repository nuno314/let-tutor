import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:let_tutor/presentation/common_widget/export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:let_tutor/presentation/theme/theme_button.dart';
import 'package:video_uploader/video_uploader.dart';

import '../../../../generated/assets.dart';
import '../../../extentions/extention.dart';
import '../../../theme/shadow.dart';
import '../../../theme/theme_color.dart';

class RegisterTutorIntroVideoScreen extends StatefulWidget {
  const RegisterTutorIntroVideoScreen();

  @override
  State<RegisterTutorIntroVideoScreen> createState() =>
      _RegisterTutorIntroVideoScreenState();
}

class _RegisterTutorIntroVideoScreenState
    extends State<RegisterTutorIntroVideoScreen> {
  late ThemeData _themeData;

  final ImagePicker _picker = ImagePicker();
  var _imagePath;
  double _progressValue = 0;

  void setProgress(double value) async {
    this.setState(() {
      this._progressValue = value;
    });
  }

  TextTheme get textTheme => _themeData.textTheme;

  late AppLocalizations trans;

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    trans = translate(context);
    return ScreenForm(
      showHeaderImage: false,
      headerColor: AppColor.primaryColor,
      bgColor: AppColor.scaffoldColor,
      trans: trans,
      title: trans.introduction,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: boxShadowlight,
          color: AppColor.white,
          borderRadius: BorderRadius.circular(16),
        ),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTitle(),
            Divider(
              height: 32,
              thickness: 1,
            ),
            _buildTips(),
            const SizedBox(height: 32),
            ThemeButton.primaryIcon(
              icon: Icon(
                Icons.ondemand_video_rounded,
                color: AppColor.white,
              ),
              bgColor: AppColor.green,
              context: context,
              title: trans.chooseVideo,
              onPressed: onTapUploadVideo,
            ),
            const SizedBox(height: 8),
            if (_progressValue != 0 && _progressValue != 1)
              LinearProgressIndicator(
                color: AppColor.primaryColor,
                backgroundColor: AppColor.primaryColorLight.withOpacity(0.4),
                value: _progressValue,
              ),
            const SizedBox(height: 64),
            Row(
              children: [
                Expanded(
                    child: ThemeButton.outline(
                  context: context,
                  title: trans.previous,
                  onPressed: onPrevious,
                )),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: ThemeButton.primary(
                  context: context,
                  title: trans.done,
                  onPressed: onDone,
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: SvgPicture.asset(
            Assets.svg.icIntroVideo,
            width: 100,
            height: 100,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            children: [
              Text(
                trans.introduction,
                style: textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                trans.introductionDescription,
                style: textTheme.bodyText2?.copyWith(
                  fontSize: 14,
                  color: AppColor.gray8C,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTips() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColor.primaryColorLight.withOpacity(0.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            trans.tips,
            style: textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 9),
          Text(
            trans.findQuiet,
            style: textTheme.bodyText2?.copyWith(fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            trans.smile,
            style: textTheme.bodyText2?.copyWith(fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            trans.dressSmart,
            style: textTheme.bodyText2?.copyWith(fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            trans.speakLong,
            style: textTheme.bodyText2?.copyWith(fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            trans.brandYourself,
            style: textTheme.bodyText2?.copyWith(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void onTapUploadVideo() async {
    var source = ImageSource.gallery;
    XFile? image = await _picker.pickVideo(source: source);
    if (image != null) {
      setState(() {
        try {
          _imagePath = image.path;
        } catch (e) {
          print("Failed to get video: $e");
        }
      });
    }

    try {
      var video = await ApiVideoUploader.uploadWithUploadToken("", _imagePath,
          (bytesSent, totalByte) {
        print("Progress : ${bytesSent / totalByte}");
        this.setProgress(bytesSent / totalByte);
      });
      print("Video : $video");
      print("Title : ${video.title}");
    } catch (e) {
      print("Failed to upload video: $e");
    }
  }

  void onPrevious() {
    Navigator.pop(
      context,
      false,
    );
  }

  void onDone() {
    showNoticeDialog(
      context: context,
      message: trans.registerSuccessfully,
      onClose: () => Navigator.pop(
        context,
        true,
      ),
      title: trans.inform,
      titleBtn: trans.confirm,
    );
  }
}
