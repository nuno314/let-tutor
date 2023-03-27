import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/presentation/base/base.dart';
import 'package:let_tutor/presentation/common_widget/export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../generated/assets.dart';
import '../../../../extentions/extention.dart';
import '../../../../route/route_list.dart';
import '../../../../theme/theme_button.dart';
import '../../../../theme/theme_color.dart';
import '../../reset_password/views/reset_password_screen.dart';
import '../bloc/phone_number_bloc.dart';
import '../../../../../common/utils.dart';

part 'phone_number.action.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({Key? key}) : super(key: key);
  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends StateBase<PhoneNumberScreen> {
  final _phoneController = InputContainerController();
  final _passwordController = InputContainerController();
  late AppLocalizations trans;
  late ThemeData _themeData;

  @override
  void onLogicError(String? message) {
    if (message?.toLowerCase().contains('incorrect') == true) {
      showNoticeDialog(
        context: context,
        message: trans.incorrectPhoneNumberOrPassword,
        title: trans.inform,
        titleBtn: trans.confirm,
        onClose: onCloseErrorDialog,
      );
    } else {
      super.onLogicError(message);
    }
  }

  TextTheme get textTheme => _themeData.textTheme;
  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    trans = translate(context);
    return BlocConsumer<PhoneNumberBloc, PhoneNumberState>(
      listener: _blocListener,
      builder: (context, state) {
        return ScreenForm(
          trans: trans,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(children: [
              _buildLoginBanner(),
              _buildLoginForm(),
              _buildButtons(),
            ]),
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
        const SizedBox(
          height: 16,
        ),
        Text(
          trans.login,
          style: textTheme.bodyLarge?.copyWith(
            color: AppColor.primaryColor,
            fontSize: 24,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Phát triển kỹ năng tiếng Anh nhanh nhất bằng cách học 1 kèm 1 trực tuyến theo mục tiêu và lộ trình dành cho riêng bạn.',
            style: textTheme.bodyLarge?.copyWith(
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
            title: trans.phoneNumber,
            hint: trans.enterPhoneNumber,
            controller: _phoneController,
          ),
          SizedBox(
            height: 8,
          ),
          InputContainer(
            title: trans.password,
            controller: _passwordController,
            isPassword: true,
            onSubmitted: (p1) => onSignIn(),
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
            onTap: onForgotPassword,
            child: Text(
              trans.forgetPassword,
              style: textTheme.bodyMedium?.copyWith(
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
            onTap: () => onSignIn(),
          ),
        ],
      ),
    );
  }

  @override
  PhoneNumberBloc get bloc => BlocProvider.of(context);
}
