import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:let_tutor/generated/assets.dart';
import 'package:let_tutor/presentation/common_widget/export.dart';
import 'package:let_tutor/presentation/route/route_list.dart';
import 'package:let_tutor/presentation/theme/shadow.dart';
import 'package:let_tutor/presentation/theme/theme_color.dart';

import '../../../base/base.dart';
import '../../../extentions/extention.dart';
import '../bloc/settings_bloc.dart';

part 'settings.action.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends StateBase<SettingsScreen> {
  @override
  SettingsBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  late AppLocalizations trans;

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    trans = translate(context);
    return BlocConsumer<SettingsBloc, SettingsState>(
      listener: _blocListener,
      builder: (context, state) {
        return ScreenForm(
          showHeaderImage: false,
          bgColor: AppColor.scaffoldColor,
          headerColor: AppColor.primaryColor,
          trans: trans,
          title: trans.settings,
          child: Column(children: [
            _buildSettings(),
          ]),
        );
      },
    );
  }

  Widget _buildSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            trans.system,
            style: textTheme.bodyLarge?.copyWith(fontSize: 12),
          ),
        ),
        const SizedBox(height: 8),
        SettingItem(title: trans.language, onTap: showLanguagePicker),
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            trans.account,
            style: textTheme.bodyLarge?.copyWith(fontSize: 12),
          ),
        ),
        const SizedBox(height: 8),
        SettingItem(title: trans.changePassword, onTap: onChangePassword),
      ],
    );
  }

  Widget CountryItem({
    required String name,
    required String iconPath,
    void Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          boxShadow: boxShadowlight,
          color: AppColor.white,
        ),
        child: Column(children: [
          Image.asset(
            iconPath,
            width: 80,
            height: 80,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            name,
            style: textTheme.bodyLarge?.copyWith(
              fontSize: 14,
            ),
          ),
        ]),
      ),
    );
  }

  Widget SettingItem({
    required String title,
    required void Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        color: AppColor.greyE5,
        child: Row(
          children: [
            Text(
              title,
              style: textTheme.bodyMedium?.copyWith(
                fontSize: 14,
              ),
            ),
            Spacer(),
            Icon(Icons.navigate_next_outlined),
          ],
        ),
      ),
    );
  }
}
