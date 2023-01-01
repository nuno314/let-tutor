// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:let_tutor/presentation/common_widget/export.dart';
import 'package:let_tutor/presentation/theme/theme_button.dart';

import '../../../../../generated/assets.dart';
import '../../../../base/base.dart';
import '../../../../extentions/extention.dart';
import '../../../../theme/theme_color.dart';
import '../sign_up.dart';
import '../../../../../common/utils.dart';

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
  final _emailController = InputContainerController();
  final _passwordController = InputContainerController();
  final _verifyPasswordController = InputContainerController();

  @override
  SignUpBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  late AppLocalizations trans;

  @override
  void onLogicError(String? message) {
    if (message?.toLowerCase().contains('already') == true) {
      showNoticeDialog(
        context: context,
        message: trans.emailAlreadyTaken,
        title: trans.inform,
        titleBtn: trans.confirm,
        onClose: onCloseErrorDialog,
      );
    } else {
      super.onLogicError(message);
    }
  }

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
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                _buildLoginBanner(),
                _buildLoginForm(),
                _buildButtons(),
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
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoginBanner() {
    return Column(
      children: [
        Image.asset(
          Assets.image.imgLogin,
          height: 250,
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
          const SizedBox(
            height: 8,
          ),
          InputContainer(
            title: trans.password,
            controller: _passwordController,
            isPassword: true,
          ),
          const SizedBox(
            height: 8,
          ),
          InputContainer(
            title: trans.verifyPassword,
            controller: _verifyPasswordController,
            isPassword: true,
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
          ThemeButton.bottomButton(
            context,
            isWithShadown: false,
            buttonTitle: trans.signUp.toUpperCase(),
            padding: EdgeInsets.all(0),
            onTap: onSignUp,
          ),
        ],
      ),
    );
  }
}
