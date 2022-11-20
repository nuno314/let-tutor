import 'package:flutter/material.dart';
import 'package:let_tutor/presentation/common_widget/export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../extentions/extention.dart';

class PhoneNumberSignInScreen extends StatefulWidget {
  const PhoneNumberSignInScreen({super.key});

  @override
  State<PhoneNumberSignInScreen> createState() =>
      _PhoneNumberSignInScreenState();
}

class _PhoneNumberSignInScreenState extends State<PhoneNumberSignInScreen> {
  late AppLocalizations trans;
  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;
  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    trans = translate(context);
    return ScreenForm(
      trans: trans,
      child: Column(children: []),
    );
  }
}
