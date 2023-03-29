// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:countries_utils/countries_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:let_tutor/common/constants.dart';
import 'package:let_tutor/presentation/common_widget/export.dart';
import 'package:let_tutor/presentation/theme/theme_button.dart';
import 'package:let_tutor/presentation/theme/theme_color.dart';

import '../../../../data/models/user.dart';
import '../../../common_widget/custom_cupertino_date_picker.dart';
import '../../../extentions/extention.dart';
import '../provider/profile_provider.dart';
import '/common/utils.dart';

part 'profile.action.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  double get avatarSize => 96;

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  late AppLocalizations trans;

  late User? _user;

  final _nameController = InputContainerController();
  final _emailController = InputContainerController();
  final _countryController = InputContainerController();
  final _phoneNumberController = InputContainerController();
  final _dobController = InputContainerController();
  final _levelController = InputContainerController();
  final _wantToLearnController = InputContainerController();
  final _scheduleController = InputContainerController();

  File? newAvatar;
  DateTime? _pickBirthday;
  List<Specialty> specialties = [];

  final avatarValue = ValueNotifier<String?>(null);
  List<Specialty> subjects = Specialty.values.sublist(1);
  late List<bool> selectedSubjects = List.generate(
    subjects.length,
    (index) => false,
  );

  late ProfileProvider provider;

  @override
  void initState() {
    provider = ref.read(profileProvider.notifier)..getUserInformation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    trans = translate(context);
    final state = ref.watch(profileProvider);
    _user = state.user;
    avatarValue.value = _user?.avatar;

    print(_user);
    return ScreenForm(
        headerColor: AppColor.primaryColor,
        bgColor: AppColor.scaffoldColor,
        title: trans.account,
        showHeaderImage: false,
        trans: trans,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              _buildProfileInfo(context),
              _buildInfoForm(context),
            ],
          ),
        ));
  }

  Widget _buildProfileInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 40,
        ),
        Center(
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              GestureDetector(
                onTap: () => tapEditAvatar(context),
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    ValueListenableBuilder<String?>(
                      valueListenable: avatarValue,
                      builder: (context, avatar, snapshot) {
                        return CircleImageOutline(
                          image: avatar ?? '',
                          borderColor: AppColor.primaryColor,
                        );
                      },
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.primaryColorLight,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(6),
                      child: Icon(
                        Icons.camera_alt_rounded,
                        size: 18,
                        color: AppColor.primaryColor,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          _user?.name ?? '',
          style: textTheme.bodyLarge?.copyWith(fontSize: 14),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          _user?.id ?? '',
          style: textTheme.bodyMedium?.copyWith(fontSize: 12),
        ),
        SizedBox(
          height: 10,
        ),
        // InkWell(
        //   onTap: () {},
        //   child: Text(
        //     'Người khác đánh giá bạn,',
        //     style: textTheme.bodyText2?.copyWith(
        //       color: AppColor.primaryColor,
        //     ),
        //   ),
        // ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _buildInfoForm(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              InputContainer(
                controller: _nameController,
                title: trans.name,
                required: true,
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
                required: true,
                readOnly: true,
                controller: _countryController,
                title: trans.country,
                onTap: () => showSelectNationDialog(context),
              ),
              SizedBox(
                height: 20,
              ),
              InputContainer(
                required: true,
                controller: _phoneNumberController,
                title: trans.phoneNumber,
                onTextChanged: (p0) {
                  // if (p0 != user?.phoneNumber) {
                  //   setState(() {
                  //     user?.isPhoneActivated = false;
                  //   });
                  // } else {
                  //   setState(() {
                  //     user?.isPhoneActivated = true;
                  //   });
                  // }
                },
              ),
              SizedBox(
                height: 20,
              ),
              InputContainer(
                required: true,
                title: trans.dateOfBirth,
                controller: _dobController,
                onTap: () => _showBirthdayPicker(context),
              ),
              SizedBox(
                height: 20,
              ),
              InputContainer(
                required: true,
                title: trans.level,
                controller: _levelController,
                onTap: () => showLevelDialog(context),
                readOnly: true,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              InputContainer(
                controller: _wantToLearnController,
                title: trans.wantToLearn,
                required: true,
                readOnly: true,
                onTap: () => showWantToLearnDialog(context),
              ),
              SizedBox(
                height: 20,
              ),
              InputContainer(
                title: trans.schedule,
                controller: _scheduleController,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                hint: trans.scheduleHint,
                maxLines: 3,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        ThemeButton.bottomButton(
          context,
          isWithShadown: false,
          buttonTitle: trans.saveChanges,
          onTap: () => saveChanges(_user),
        ),
      ],
    );
  }

  void tapEditAvatar(BuildContext context) async {
    final file = await ImagePicker(
      context,
      trans.changeAvatar,
      crop: true,
    ).show();
    if (file != null) {
      avatarValue.value = file.path;
      newAvatar = file;
    }
  }
}
