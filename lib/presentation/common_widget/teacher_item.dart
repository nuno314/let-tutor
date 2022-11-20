import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:let_tutor/presentation/theme/theme_color.dart';

import '../../data/models/teacher.dart';
import '../../generated/assets.dart';
import 'cache_network_image_wrapper.dart';

class TeacherItem extends StatelessWidget {
  final Teacher teacher;
  final TextTheme textTheme;
  const TeacherItem({
    required this.teacher,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.grayAD,
            offset: const Offset(0, 2),
            spreadRadius: -1,
            blurRadius: 2,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(),
                    child: Stack(
                      children: [
                        ClipOval(
                          child: CachedNetworkImageWrapper.item(
                            url: teacher.avatarUrl ?? '',
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 75,
                          child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Icon(
                Icons.favorite_outline,
                color: AppColor.primaryColor,
                size: 40,
              )
            ],
          ),
          Text(
            teacher.name ?? '--',
            style: textTheme.bodyText1?.copyWith(fontSize: 30),
          ),
          Row(
            children: [
              CachedNetworkImageWrapper.item(
                url: teacher.countryUrl ?? '',
                fit: BoxFit.cover,
                width: 50,
                height: 50,
              ),
              Text(
                teacher.country ?? ' --',
                style: textTheme.bodyText2?.copyWith(
                  fontSize: 16,
                  color: AppColor.grayAD,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.star,
                color: AppColor.yellowFADB14,
              ),
              Icon(
                Icons.star,
                color: AppColor.yellowFADB14,
              ),
              Icon(
                Icons.star,
                color: AppColor.yellowFADB14,
              ),
              Icon(
                Icons.star,
                color: AppColor.yellowFADB14,
              ),
              Icon(
                Icons.star,
                color: AppColor.yellowFADB14,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: teacher.categories!
                .map(
                  (e) => Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: AppColor.bluecee8f0,
                    ),
                    child: Text(
                      e,
                      style: textTheme.bodyText2?.copyWith(
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            teacher.description ?? '--',
            style: textTheme.bodyText2?.copyWith(
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Spacer(),
              InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColor.primaryColor,
                      ),
                      borderRadius: BorderRadius.circular(32)),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        Assets.svg.icSchedule,
                        width: 20,
                        height: 20,
                        color: AppColor.primaryColor,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Đặt lịch',
                        style: textTheme.bodyText2?.copyWith(
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
