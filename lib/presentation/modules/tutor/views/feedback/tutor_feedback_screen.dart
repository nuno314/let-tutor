import 'package:flutter/material.dart';
import 'package:let_tutor/data/models/teacher.dart' as fb;

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:let_tutor/presentation/common_widget/feedback_item.dart';
import 'package:let_tutor/presentation/common_widget/input_container/input_container.dart';

import '../../../../common_widget/forms/screen_form.dart';
import '../../../../extentions/extention.dart';
import '../../../../theme/theme_color.dart';

class FeedbackScreen extends StatefulWidget {
  final List<fb.Feedback> feedbacks;
  const FeedbackScreen({required this.feedbacks});

  @override
  State<FeedbackScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<FeedbackScreen> {
  final controller = InputContainerController();
  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  late AppLocalizations trans;

  List<fb.Feedback> get feedbacks => widget.feedbacks;

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    trans = translate(context);
    return ScreenForm(
      headerColor: AppColor.primaryColor,
      bgColor: AppColor.scaffoldColor,
      title: trans.reviews,
      showHeaderImage: false,
      trans: trans,
      child: _buildListing(),
    );
  }

  Widget _buildListing() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              
              (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: FeedbackItem(
                    feedback: feedbacks.elementAt(index),
                    textTheme: textTheme,
                    trans: trans),
              ),
              childCount: feedbacks.length,
            ),
          ),
        ],
      ),
    );
  }
}
