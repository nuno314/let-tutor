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
              Center(
                child: Container(
                  decoration: BoxDecoration(),
                  child: Stack(
                    children: [
                      ClipOval(
                        child: CachedNetworkImageWrapper.item(
                          url: teacher.avatar ?? '',
                          fit: BoxFit.cover,
                          width: 68,
                          height: 68,
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        left: 55,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: teacher.isOnline == true
                                ? Colors.green
                                : Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        teacher.name ?? '--',
                        style: textTheme.bodyText1?.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  if (teacher.country != null)
                    Text(
                      teacher.country!.toUpperCase().replaceAllMapped(
                            RegExp(r'[A-Z]'),
                            (match) => String.fromCharCode(
                              match.group(0)!.codeUnitAt(0) + 127397,
                            ),
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(
                    height: 0,
                  ),
                  if (teacher.rating != null)
                    Row(
                      children: List.generate(
                        5,
                        (index) => _buildRating(index < teacher.rating!.toInt()
                            ? AppColor.yellowFADB14
                            : Colors.grey),
                      ),
                    ),
                ],
              ),
              Spacer(),
              Icon(
                Icons.favorite_outline,
                color: AppColor.red,
                size: 30,
              )
            ],
          ),
          Divider(
            height: 32,
            thickness: 1,
          ),
          Text(
            teacher.bio ?? '--',
            style: textTheme.bodyText2?.copyWith(
              fontSize: 14,
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

  Widget _buildRating(Color color) {
    return Icon(
      Icons.star,
      color: color,
    );
  }
}
