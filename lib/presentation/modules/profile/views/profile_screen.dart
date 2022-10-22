import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:let_tutor/presentation/common_widget/export.dart';
import 'package:let_tutor/presentation/theme/theme_color.dart';

import '../../../../data/models/user.dart';
import '../../../base/base.dart';
import '../../../extentions/extention.dart';
import '../../../theme/shadow.dart';
import '../bloc/profile_bloc.dart';

part 'profile.action.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends StateBase<ProfileScreen> {
  @override
  ProfileBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  @override
  late AppLocalizations trans;

  User get user => widget.user;

  final _nameController = InputContainerController();
  final _emailController = InputContainerController();
  final _countryController = InputContainerController();
  final _phoneNumberController = InputContainerController();
  final _dobController = InputContainerController();
  final _levelController = InputContainerController();

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.user);
    _themeData = Theme.of(context);
    trans = translate(context);
    return ScreenForm(
      trans: trans,
      showHeaderImage: false,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildProfileInfo(widget.user),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo(User user) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 50,
        horizontal: 20,
      ),
      width: double.infinity,
      decoration: const BoxDecoration(
        boxShadow: boxShadowlight,
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Stack(
              children: [
                ClipOval(
                  child: CachedNetworkImageWrapper.item(
                    url: user.avatarUrl ?? '',
                    fit: BoxFit.cover,
                    width: 150,
                    height: 150,
                  ),
                ),
                Positioned(
                  right: -10,
                  bottom: 0,
                  child: IconButton(
                    onPressed: () {},
                    icon: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.primaryColor,
                      ),
                      child: Icon(
                        Icons.edit,
                        size: 20,
                        color: AppColor.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            user.name ?? '--',
            style: textTheme.bodyText1?.copyWith(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'ID: ${user.id}',
            style: textTheme.bodyText2?.copyWith(),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {},
            child: Text(
              'Người khác đánh giá bạn,',
              style: textTheme.bodyText2?.copyWith(
                color: AppColor.primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ..._buildInfoForm(user),
        ],
      ),
    );
  }

  List<Widget> _buildInfoForm(User user) {
    return [
      Container(
        padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        width: double.infinity,
        color: AppColor.greyE5,
        child: Text(
          'Tài khoản',
          style: textTheme.bodyText2,
        ),
      ),
      SizedBox(
        height: 20,
      ),
      InputContainer(
        controller: _nameController,
        title: 'Tên',
        isRequired: true,
      ),
      SizedBox(
        height: 20,
      ),
      InputContainer(
        fillColor: AppColor.greyE5,
        readOnly: true,
        controller: _emailController,
        title: trans.emailAddress,
      ),
      SizedBox(
        height: 20,
      ),
      InputContainer(
        controller: _countryController,
        title: 'Quốc gia',
      ),
      SizedBox(
        height: 20,
      ),
      InputContainer(
        isRequired: true,
        fillColor: AppColor.greyE5,
        controller: _phoneNumberController,
        title: 'Số điện thoại',
      ),
      if (user.phoneNumberValidate == true) ...[
        SizedBox(
          height: 4,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColor.green,
            ),
            color: AppColor.greenB7EB8F,
          ),
          child: Text(
            'Đã xác thực',
            style: textTheme.bodyText1?.copyWith(
              color: AppColor.green,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        InputContainer(
          isRequired: true,
          title: 'Ngày sinh',
          controller: _dobController,
        ),
        SizedBox(
          height: 20,
        ),
        InputContainer(
          isRequired: true,
          title: 'Trình độ',
          controller: _levelController,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          '* Muốn học',
          style: textTheme.bodyText1?.copyWith(),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
              border: Border.all(
                color: AppColor.greyE5,
              ),
              color: AppColor.transparent,
              borderRadius: BorderRadius.circular(12)),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: user.wantToLearn!
                .map((e) => Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      color: AppColor.greyE5,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(e),
                          Icon(
                            Icons.cancel_outlined,
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Lịch học',
          style: textTheme.bodyText1?.copyWith(),
        ),
        InputContainer(
          hint: 'Ghi chú thời gian trong tuần mà bạn muốn học trên LetTutor',
          maxLines: 3,
        ),
        SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: InkWell(
            onTap: saveChanges,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColor.primaryColor,
              ),
              child: Text(
                'Lưu thay đổi',
                style: textTheme.bodyText2?.copyWith(
                  color: AppColor.white,
                ),
              ),
            ),
          ),
        ),
      ],
    ];
  }

  
}
