// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:let_tutor/presentation/common_widget/export.dart';
import 'package:let_tutor/presentation/theme/theme_button.dart';

import '../../../../../generated/assets.dart';
import '../../../../base/base.dart';
import '../../../../extentions/extention.dart';
import '../../../../theme/theme_color.dart';
import '../sign_up.dart';

part 'sign_up.action.dart';

class LoginOptionArgs {
  String iconPath;
  void Function() onTap;
  LoginOptionArgs({
    required this.iconPath,
    required this.onTap,
  });
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends StateBase<SignUpScreen> {
  @override
  SignUpBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  @override
  late AppLocalizations trans;

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    trans = translate(context);
    final _size = MediaQuery.of(context).size;
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: _blocListener,
      builder: (context, state) {
        return ScreenForm(
          trans: trans,
          showHeaderImage: false,
          showBackButton: false,
          iconTitle: SvgPicture.asset(
            Assets.svg.icLogo,
            height: 40,
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                _buildLoginBanner(),
                _buildLoginForm(),
                _buildButtons(),
                _buildLoginOptions()
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLanguageSelection() {
    final languageList = [
      DropdownLanguageArgs(
        title: trans.vietnamese,
        iconPath: Assets.svg.icVietnam,
      ),
      DropdownLanguageArgs(
        title: trans.english,
        iconPath: Assets.svg.icUs,
      ),
    ];
    var _selectedLanguage = languageList[0];

    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton<DropdownLanguageArgs>(
          value: _selectedLanguage,
          items: languageList
              .map(
                (e) => DropdownMenuItem<DropdownLanguageArgs>(
                  child: Container(
                    width: 100,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(e.title),
                        Spacer(),
                        SvgPicture.asset(
                          e.iconPath,
                          height: 35,
                        ),
                      ],
                    ),
                  ),
                  value: e,
                ),
              )
              .toList(),
          onChanged: (value) {
            setState(() {
              _selectedLanguage = value as DropdownLanguageArgs;
            });
          },
        ),
      ),
    );
  }

  Widget _buildLoginBanner() {
    return Column(
      children: [
        Image.asset(
          Assets.image.imgLogin,
          width: double.infinity,
        ),
        Text(
          trans.signUp,
          style: textTheme.bodyText1?.copyWith(
            color: AppColor.primaryColor,
            fontSize: 30,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Phát triển kỹ năng tiếng Anh nhanh nhất bằng cách học 1 kèm 1 trực tuyến theo mục tiêu và lộ trình dành cho riêng bạn.',
            style: textTheme.bodyText1?.copyWith(
              fontSize: 16,
            ),
            maxLines: 3,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    final _emailController = InputContainerController();
    final _passwordController = InputContainerController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          InputContainer(
            title: trans.emailAddress,
            hint: 'mail@example.com',
            controller: _emailController,
          ),
          InputContainer(
            title: trans.password,
            controller: _passwordController,
          ),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {},
            child: Text(
              trans.forgetPassword,
              style: textTheme.bodyText2?.copyWith(
                fontSize: 16,
                color: AppColor.primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          ThemeButton.bottomButton(
            context,
            isWithShadown: false,
            buttonTitle: trans.signUp.toUpperCase(),
            padding: EdgeInsets.all(0),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginOptions() {
    final loginOptions = [
      LoginOptionArgs(
        iconPath: Assets.svg.icFacebook,
        onTap: onLoginWithFacebook,
      ),
      LoginOptionArgs(
        iconPath: Assets.svg.icGoogle,
        onTap: onLoginWithGoogle,
      ),
      LoginOptionArgs(
        iconPath: Assets.svg.icPhone,
        onTap: onLoginWithPhoneNumber,
      ),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 32,
      ),
      child: Column(
        children: [
          Text(trans.orContinueWith),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: loginOptions
                .map((e) => _buildLoginOptionIcon(
                      e.iconPath,
                      e.onTap,
                    ))
                .toList(),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                trans.haveAccount,
              ),
              InkWell(
                onTap: onSignIn,
                child: Text(
                  trans.login,
                  style: textTheme.bodyText2?.copyWith(
                    color: AppColor.primaryColor,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLoginOptionIcon(
    String iconPath,
    void Function() onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: SvgPicture.asset(
          iconPath,
          width: 50,
        ),
      ),
    );
  }
}
