import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:let_tutor/presentation/extentions/extention.dart';
import 'package:let_tutor/presentation/theme/theme_color.dart';

import '../../data/models/teacher.dart';
import '../../generated/assets.dart';
import 'cache_network_image_wrapper.dart';

class TeacherItem extends StatelessWidget {
  final Teacher teacher;
  final TextTheme textTheme;
  final void Function()? onTapFavorite;
  const TeacherItem({
    required this.teacher,
    required this.textTheme,
    this.onTapFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                          width: 50,
                          height: 50,
                        ),
                      ),
                      Positioned(
                        bottom: 2,
                        left: 38,
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
                        style: textTheme.bodyLarge?.copyWith(
                          fontSize: 14,
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
                      style: textTheme.bodyLarge?.copyWith(fontSize: 12),
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
              InkWell(
                onTap: onTapFavorite,
                child: Icon(
                  teacher.isFavorite ? Icons.favorite : Icons.favorite_outline,
                  color: AppColor.red,
                  size: 16,
                ),
              )
            ],
          ),
          Divider(
            height: 32,
            thickness: 1,
          ),
          Text(
            teacher.bio ?? '--',
            style: textTheme.bodyMedium?.copyWith(
              fontSize: 12,
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
                        translate(context).book,
                        style: textTheme.bodyLarge?.copyWith(
                          color: AppColor.primaryColor,
                          fontSize: 12,
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
      size: 16,
    );
  }
}
