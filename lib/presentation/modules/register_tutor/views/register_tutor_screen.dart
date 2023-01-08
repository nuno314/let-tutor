import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:let_tutor/common/constants.dart';
import 'package:let_tutor/common/utils.dart';
import 'package:let_tutor/data/data_source/remote/app_api_service.dart';
import 'package:let_tutor/di/di.dart';
import 'package:let_tutor/presentation/common_widget/export.dart';
import 'package:let_tutor/presentation/route/route_list.dart';
import 'package:let_tutor/presentation/theme/shadow.dart';
import 'package:let_tutor/presentation/theme/theme_button.dart';

import '../../../../data/models/user.dart';
import '../../../base/base.dart';
import '../../../common_widget/box_color.dart';
import '../../../common_widget/custom_cupertino_date_picker.dart';
import '../../../extentions/extention.dart';
import '../../../theme/theme_color.dart';
import '../bloc/register_tutor_bloc.dart';

part 'register_tutor.action.dart';

class RegisterTutorScreen extends StatefulWidget {
  const RegisterTutorScreen({Key? key}) : super(key: key);

  @override
  State<RegisterTutorScreen> createState() => _RegisterTutorScreenState();
}

class _RegisterTutorScreenState extends StateBase<RegisterTutorScreen> {
  final _nameController = InputContainerController();
  final _nationalityController = InputContainerController();
  final _dobController = InputContainerController();
  final _interestsController = InputContainerController();
  final _educationController = InputContainerController();
  final _experienceController = InputContainerController();
  final _professionController = InputContainerController();
  final _languagesController = InputContainerController();
  final _introductionController = InputContainerController();

  final List<LevelEnum> levelEnumFilter = [
    LevelEnum.beginner,
    LevelEnum.intermediate,
    LevelEnum.advanced,
  ];

  late var _selectedLevel = levelEnumFilter.first;
  late var specialties = <Specialty>[];

  @override
  RegisterTutorBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  late AppLocalizations trans;
  final avatarValue = ValueNotifier<String?>(null);

  User get user => injector.get<AppApiService>().currentUser!;
  DateTime? _pickBirthday;

  @override
  void initState() {
    _nameController.text = user.name;
    _nationalityController.text = user.country;
    if (user.birthday != 'Invalid date') _dobController.text = user.birthday;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    trans = translate(context);
    return BlocConsumer<RegisterTutorBloc, RegisterTutorState>(
      listener: _blocListener,
      builder: (context, state) {
        return ScreenForm(
          showHeaderImage: false,
          headerColor: AppColor.primaryColor,
          bgColor: AppColor.scaffoldColor,
          trans: trans,
          title: trans.becomeATutor,
          child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: boxShadowlight,
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  children: [
                    _buildTitle(),
                    Divider(
                      height: 32,
                      thickness: 1,
                    ),
                    _buildForm(),
                    Divider(
                      height: 32,
                      thickness: 1,
                    ),
                    _buildCV(),
                    Divider(
                      height: 32,
                      thickness: 1,
                    ),
                    _buildLanguages(),
                    Divider(
                      height: 32,
                      thickness: 1,
                    ),
                    _buildSpecialties(),
                    const SizedBox(height: 32),
                    Container(
                      width: double.infinity,
                      child: ThemeButton.primary(
                        context: context,
                        title: trans.next,
                        onPressed: onNext,
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }

  Widget _buildTitle() {
    return Row(
      children: [
        Center(
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              GestureDetector(
                onTap: tapEditAvatar,
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    ValueListenableBuilder<String?>(
                      valueListenable: avatarValue,
                      builder: (context, avatar, snapshot) {
                        return CircleImageOutline(
                          image: avatar ?? user.avatar ?? '',
                        );
                      },
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColor.green, width: 2),
                      ),
                      padding: const EdgeInsets.all(6),
                      child: Icon(
                        Icons.camera_alt_rounded,
                        size: 18,
                        color: AppColor.green,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        // ClipRRect(
        //   borderRadius: BorderRadius.circular(100),
        //   child: Image.asset(
        //     Assets.image.icRegisterTutor,
        //     width: 100,
        //     height: 100,
        //   ),
        // ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                trans.setUpYourTutorProfile,
                style: textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                trans.setUpYourTutorProfileDescription,
                style: textTheme.bodyText2?.copyWith(
                  fontSize: 12,
                  color: AppColor.gray8C,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    trans.basicInfo,
                    style: textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 2),
                  const SizedBox(height: 8),
                  _buildInputContainer(
                      controller: _nameController, title: trans.name),
                  const SizedBox(height: 8),
                  _buildInputContainer(
                      controller: _nationalityController,
                      title: trans.nationality),
                  const SizedBox(height: 8),
                  _buildInputContainer(
                    controller: _dobController,
                    title: trans.dateOfBirth,
                    onTap: _showBirthdayPicker,
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  void tapEditAvatar() {}

  Widget _buildCV() {
    return Column(
      children: [
        Text(
          'CV',
          style: textTheme.bodyText1,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          trans.doNotSharePersonalInformation,
          style: textTheme.bodyText2?.copyWith(
            fontSize: 12,
            color: AppColor.red,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        _buildInputContainer(
          controller: _interestsController,
          title: trans.interests,
        ),
        const SizedBox(height: 8),
        _buildInputContainer(
          controller: _educationController,
          title: trans.education,
        ),
        const SizedBox(height: 8),
        _buildInputContainer(
          controller: _experienceController,
          title: trans.teachingExperience,
        ),
        const SizedBox(height: 8),
        _buildInputContainer(
          controller: _professionController,
          title: trans.profession,
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildLanguages() {
    return Column(
      children: [
        Text(
          trans.languages,
          style: textTheme.bodyText1,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        _buildInputContainer(
          controller: _languagesController,
          title: trans.languages,
          onTap: showSelectLanguagesDialog,
          showSuffixIcon: true,
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildSpecialties() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          trans.students,
          style: textTheme.bodyText1,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          trans.studentsWillSee,
          style: textTheme.bodyText2
              ?.copyWith(fontSize: 12, color: AppColor.primaryColor),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        _buildInputContainer(
          controller: _introductionController,
          title: trans.introduction,
          maxLines: 3,
        ),
        const SizedBox(height: 8),
        Text(
          trans.bestAtTeaching,
          style: textTheme.bodyText1,
        ),
        _buildLevelFilter(),
        const SizedBox(height: 8),
        Text(
          trans.specialty,
          style: textTheme.bodyText1,
        ),
        _buildGroupFilter()
      ],
    );
  }

  Widget _buildInputContainer({
    required InputContainerController controller,
    required String title,
    void Function()? onTap,
    bool showSuffixIcon = false,
    int? maxLines,
  }) {
    return InputContainer(
      controller: controller,
      title: title,
      required: true,
      titleStyle: textTheme.bodyText1,
      onTap: onTap,
      suffixIcon: showSuffixIcon && controller.text?.isNotEmpty == true
          ? InkWell(
              onTap: () {
                controller.setText = '';
              },
              child: Icon(Icons.clear))
          : null,
      suffixIconPadding: const EdgeInsets.only(
        right: 14,
        left: 12,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      maxLines: maxLines,
    );
  }

  Widget _buildLevelFilter() {
    return Wrap(
      children: [
        ...levelEnumFilter.map(_buildLevelsItem),
      ],
    );
  }

  Widget _buildLevelsItem(LevelEnum e) {
    final selected = e == _selectedLevel;
    return Padding(
      padding: const EdgeInsets.only(right: 12, top: 12),
      child: ChipItem(
        onTap: (selected) {
          setState(() {
            _selectedLevel = e;
          });
        },
        text: e.description(),
        selected: selected,
        textTheme: textTheme,
      ),
    );
  }

  Widget _buildGroupFilter() {
    return Wrap(
      children: [
        ...Specialty.values.map(_buildSpecialtiesItem),
      ],
    );
  }

  Widget _buildSpecialtiesItem(Specialty e) {
    final selected = specialties.contains(e);
    return Padding(
      padding: const EdgeInsets.only(right: 12, top: 12),
      child: ChipItem(
        onTap: (selected) {
          setState(() {
            var gs = <Specialty>[];
            if (selected) {
              if (e == Specialty.all) {
                gs.clear();
              } else {
                gs = [...specialties..removeWhere((element) => element == e)];
              }
            } else if (!selected) {
              if (e == Specialty.all) {
                gs = [...Specialty.values];
              } else {
                gs = [...specialties, e];
              }
            } else {
              gs = [...specialties];
            }

            specialties
              ..clear()
              ..addAll(gs);
          });
        },
        text: e.localized(trans),
        selected: selected,
        textTheme: textTheme,
      ),
    );
  }
}
