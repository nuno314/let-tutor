import 'package:flutter/material.dart';
import 'package:let_tutor/common/utils.dart';
import 'package:let_tutor/data/models/teacher.dart' as fb;
import 'package:let_tutor/presentation/common_widget/cache_network_image_wrapper.dart';

import 'package:let_tutor/presentation/theme/shadow.dart';
import 'package:let_tutor/presentation/theme/theme_color.dart';

class FeedbackItem extends StatelessWidget {
  final fb.Feedback feedback;
  final TextTheme textTheme;
  final dynamic trans;
  const FeedbackItem({
    required this.feedback,
    required this.textTheme,
    required this.trans,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        boxShadow: boxShadowlight,
        color: AppColor.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTitle(context),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: CachedNetworkImageWrapper.avatar(
            url: feedback.firstInfo?.avatar ?? '',
            width: 48,
            height: 48,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              feedback.firstInfo?.name ?? '--',
              style: textTheme.bodyLarge?.copyWith(),
            ),
            const SizedBox(
              height: 4,
            ),
            if (feedback.rating != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(
                  5,
                  (index) => _buildRating(index < feedback.rating!.toInt()
                      ? AppColor.yellowFADB14
                      : Colors.grey),
                ),
              ),
            const SizedBox(
              height: 4,
            ),
            Text(
              feedback.updatedAt?.toLocal().serverToNormalFullFormat() ?? '--',
              style: textTheme.bodyMedium?.copyWith(
                fontSize: 12,
                color: AppColor.gray8C,
              ),
              textAlign: TextAlign.right,
            )
          ],
        ),
        const Spacer(),
        Text(
          feedback.content ?? '--',
          style: textTheme.bodyMedium?.copyWith(
            fontSize: 12,
            color: AppColor.gray8C,
          ),
        ),
      ],
    );
  }

  Widget _buildRating(Color color) {
    return Icon(
      Icons.star,
      color: color,
      size: 12,
    );
  }
}
