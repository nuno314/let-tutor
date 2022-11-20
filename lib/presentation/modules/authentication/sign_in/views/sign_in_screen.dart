// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:let_tutor/presentation/common_widget/export.dart';
import 'package:let_tutor/presentation/theme/theme_button.dart';

import '../../../../../common/components/navigation/navigation_observer.dart';
import '../../../../../generated/assets.dart';
import '../../../../base/base.dart';
import '../../../../extentions/extention.dart';
import '../../../../route/route_list.dart';
import '../../../../theme/theme_color.dart';
import '../bloc/sign_in_bloc.dart';
import '../../../../../common/utils.dart';

part 'sign_in.action.dart';

class DropdownLanguageArgs {
  String title;
  String iconPath;
  DropdownLanguageArgs({
    required this.title,
    required this.iconPath,
  });
}

class LoginOptionArgs {
  String iconPath;
  void Function() onTap;
  LoginOptionArgs({
    required this.iconPath,
    required this.onTap,
  });
}

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends StateBase<SignInScreen> {
  @override
  SignInBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  late AppLocalizations trans;

  final _emailController = InputContainerController();
  final _passwordController = InputContainerController();

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    trans = translate(context);
    return BlocConsumer<SignInBloc, SignInState>(
      listener: _blocListener,
      builder: (context, state) {
        return ScreenForm(
          trans: trans,
          showHeaderImage: false,
          showBackButton: false,
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
          height: 250,
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          trans.login,
          style: textTheme.bodyText1?.copyWith(
            color: AppColor.primaryColor,
            fontSize: 24,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Phát triển kỹ năng tiếng Anh nhanh nhất bằng cách học 1 kèm 1 trực tuyến theo mục tiêu và lộ trình dành cho riêng bạn.',
            style: textTheme.bodyText1?.copyWith(
              fontSize: 14,
            ),
            maxLines: 3,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          InputContainer(
            title: trans.emailAddress,
            hint: 'mail@example.com',
            controller: _emailController,
          ),
          SizedBox(
            height: 8,
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
            onTap: onResetPassword,
            child: Text(
              trans.forgetPassword,
              style: textTheme.bodyText2?.copyWith(
                fontSize: 14,
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
            buttonTitle: trans.login.toUpperCase(),
            padding: EdgeInsets.all(0),
            onTap: () => onSignIn(
              _emailController.text,
              _passwordController.text,
            ),
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
                trans.noAccount,
                style: textTheme.bodyText2,
              ),
              InkWell(
                onTap: onSignUp,
                child: Text(
                  trans.signUp,
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
