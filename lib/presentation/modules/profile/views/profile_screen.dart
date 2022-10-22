import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:let_tutor/presentation/common_widget/export.dart';

import '../../../base/base.dart';
import '../../../extentions/extention.dart';
import '../bloc/profile_bloc.dart';

part 'profile.action.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends StateBase<ProfileScreen> {
  @override
  ProfileBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  @override
  late AppLocalizations trans;

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    trans = translate(context);
    return ScreenForm(
      trans: trans,
      showHeaderImage: false,
      child: _buildProfileForm(),
    );
  }

  Widget _buildProfileForm() {
    return Container();
  }
}
