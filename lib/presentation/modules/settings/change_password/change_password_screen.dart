import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:let_tutor/common/utils.dart';
import 'package:let_tutor/presentation/base/base.dart';
import 'package:let_tutor/presentation/common_widget/export.dart';
import 'package:let_tutor/presentation/modules/settings/change_password/bloc/change_password_bloc.dart';
import 'package:let_tutor/presentation/theme/theme_button.dart';

import '../../../extentions/extention.dart';
import '../../../theme/theme_color.dart';

part 'change_password.action.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen();

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends StateBase<ChangePasswordScreen> {
  final _curController = InputContainerController();
  final _newController = InputContainerController();
  final _verifyController = InputContainerController();
  late AppLocalizations trans;

  @override
  ChangePasswordBloc get bloc => BlocProvider.of(context);

  @override
  void onLogicError(String? message) {
    if (message?.toLowerCase().contains('incorrect') == true) {
      showNoticeDialog(
        context: context,
        message: trans.incorrectCurrentPassword,
        title: trans.inform,
        titleBtn: trans.confirm,
        onClose: onCloseErrorDialog,
      );
    } else
      super.onLogicError(message);
  }

  @override
  Widget build(BuildContext context) {
    trans = translate(context);
    return BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
      listener: _blocListener,
      builder: (context, state) {
        return ScreenForm(
          trans: trans,
          title: trans.forgetPassword,
          showHeaderImage: false,
          bgColor: AppColor.scaffoldColor,
          headerColor: AppColor.primaryColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 16,
            ),
            child: Column(
              children: [
                InputContainer(
                  controller: _curController,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  title: trans.currentPassword,
                  isPassword: true,
                  hint: trans.enterCurrentPassword,
                ),
                SizedBox(
                  height: 8,
                ),
                InputContainer(
                  controller: _newController,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  title: trans.newPassword,
                  isPassword: true,
                  hint: trans.enterNewPassword,
                ),
                SizedBox(
                  height: 8,
                ),
                InputContainer(
                  controller: _verifyController,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  title: trans.verifyPassword,
                  isPassword: true,
                  hint: trans.enterVerifyPassword,
                ),
                SizedBox(
                  height: 40,
                ),
                ThemeButton.primary(
                  context: context,
                  title: trans.changePassword,
                  onPressed: onChangePassword,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
