import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:let_tutor/presentation/route/route_list.dart';
import 'package:let_tutor/presentation/theme/theme_color.dart';

import '../../generated/assets.dart';
import 'cache_network_image_wrapper.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => new _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  late TextTheme textTheme;
  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          _buildMenuItem(
            title: 'Long Long',
            avatarPath:
                'https://sandbox.api.lettutor.com/avatar/f569c202-7bbf-4620-af77-ecc1419a6b28avatar1657037111897.jpg',
            onTap: () {
              Navigator.pushNamed(context, RouteList.profile);
            },
          ),
          _buildMenuItem(
            title: 'Mua buổi học',
            iconPath: Assets.svg.icBookMedical,
            onTap: () {},
          ),
          _buildMenuItem(
            title: 'Đổi mật khẩu',
            iconPath: Assets.svg.icKey,
            onTap: () {},
          ),
          _buildMenuItem(
            title: 'Gia sư',
            iconPath: Assets.svg.icChalkboardTeacher,
            onTap: () {},
          ),
          _buildMenuItem(
            title: 'Lịch học',
            iconPath: Assets.svg.icScheduleCheck,
            onTap: () {},
          ),
          _buildMenuItem(
            title: 'Lịch sử',
            iconPath: Assets.svg.icHistory,
            onTap: () {},
          ),
          _buildMenuItem(
            title: 'Khóa học',
            iconPath: Assets.svg.icGraduationCap,
            onTap: () {},
          ),
          _buildMenuItem(
            title: 'Khóa học của bạn',
            iconPath: Assets.svg.icBookOpen,
            onTap: () {},
          ),
          _buildMenuItem(
            title: 'Đăng ký làm gia sư',
            iconPath: Assets.svg.icUserGraduate,
            onTap: () {},
          ),
          _buildMenuItem(
            title: 'Đăng xuất',
            iconPath: Assets.svg.icLogout,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required String title,
    String? iconPath,
    String? avatarPath,
    required void Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            if (avatarPath != null)
              Expanded(
                flex: 1,
                child: ClipOval(
                  child: CachedNetworkImageWrapper.item(
                    url: avatarPath,
                    fit: BoxFit.cover,
                    width: 70,
                    height: 70,
                  ),
                ),
              ),
            if (iconPath != null)
              Expanded(
                flex: 1,
                child: SvgPicture.asset(
                  iconPath,
                  color: AppColor.primaryColor,
                  height: 50,
                  width: 50,
                ),
              ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: textTheme.bodyLarge?.copyWith(
                  fontSize: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
