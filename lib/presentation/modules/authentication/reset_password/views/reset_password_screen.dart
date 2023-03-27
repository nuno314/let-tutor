import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:let_tutor/presentation/theme/theme_button.dart';

import '../../../../base/base.dart';
import '../../../../common_widget/export.dart';
import '../../../../extentions/extention.dart';
import '../bloc/reset_password_bloc.dart';
import '../../../../../common/utils.dart';

part 'reset_password.action.dart';

class ResetPasswordScreenArgs {
  final String? email;
  final String? phoneNumber;

  ResetPasswordScreenArgs({
    this.email = null,
    this.phoneNumber = null,
  });
}

class ResetPasswordScreen extends StatefulWidget {
  final ResetPasswordScreenArgs args;
  const ResetPasswordScreen({Key? key, required this.args}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends StateBase<ResetPasswordScreen> {
  final _emailController = InputContainerController();
  final _phoneNumberController = InputContainerController();
  @override
  ResetPasswordBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  late AppLocalizations trans;

  bool get isEmail => widget.args.email != null;

  @override
  void onLogicError(String? message) {
    if (message?.toLowerCase().contains('exist') == true) {
      showNoticeDialog(
        context: context,
        message: trans.emailNotExist,
        title: trans.inform,
        titleBtn: trans.confirm,
        onClose: onCloseErrorDialog,
      );
    } else
      super.onLogicError(message);
  }

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    trans = translate(context);

    return BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
      listener: _blocListener,
      builder: (context, state) {
        return ScreenForm(
          trans: trans,
          showHeaderImage: false,
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (isEmail) ...[
                  _buildEmailTitle(),
                  _buildEmailForm(),
                ] else ...[
                  _buildPhoneNumberTitle(),
                  _buildPhoneNumberForm(),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmailTitle() {
    return Column(
      children: [
        Text(
          trans.resetPassword,
          style: textTheme.bodyLarge?.copyWith(fontSize: 30),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          trans.pleaseEnterEmailToResetPassword,
          style: textTheme.bodyMedium?.copyWith(
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPhoneNumberTitle() {
    return Column(
      children: [
        Text(
          trans.resetPassword,
          style: textTheme.bodyLarge?.copyWith(fontSize: 30),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          trans.pleaseEnterPhoneNumberToResetPassword,
          style: textTheme.bodyMedium?.copyWith(
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildEmailForm() {
    return Column(
      children: [
        InputContainer(
          title: trans.emailAddress,
          controller: _emailController,
        ),
        SizedBox(
          height: 20,
        ),
        ThemeButton.primary(
          context: context,
          title: trans.confirm,
          onPressed: onSubmitEmail,
        ),
      ],
    );
  }

  Widget _buildPhoneNumberForm() {
    return Column(
      children: [
        InputContainer(
          title: trans.phoneNumber,
          controller: _phoneNumberController,
        ),
        SizedBox(
          height: 20,
        ),
        ThemeButton.primary(
          context: context,
          title: trans.confirm,
          onPressed: onSubmitEmail,
        ),
      ],
    );
  }
}
