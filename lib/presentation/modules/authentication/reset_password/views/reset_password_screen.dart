import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:let_tutor/presentation/route/route_list.dart';
import 'package:let_tutor/presentation/theme/theme_button.dart';

import '../../../../../generated/assets.dart';
import '../../../../base/base.dart';
import '../../../../common_widget/export.dart';
import '../../../../extentions/extention.dart';
import '../bloc/reset_password_bloc.dart';

part 'reset_password.action.dart';
part 'reset_password_confirm_screen.dart';

class DropdownLanguageArgs {
  String title;
  String iconPath;
  DropdownLanguageArgs({
    required this.title,
    required this.iconPath,
  });
}

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends StateBase<ResetPasswordScreen> {
  @override
  ResetPasswordBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  @override
  late AppLocalizations trans;

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
          iconTitle: SvgPicture.asset(
            Assets.svg.icLogo,
            height: 40,
          ),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTitle(),
                _buildForm(),
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
          onChanged: (value) {},
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Text(
          trans.resetPassword,
          style: textTheme.bodyText1?.copyWith(fontSize: 30),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          trans.pleaseEnterEmailToResetPassword,
          style: textTheme.bodyText2?.copyWith(
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      children: [
        InputContainer(
          title: trans.emailAddress,
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
