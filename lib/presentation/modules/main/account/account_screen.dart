import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/presentation/base/base.dart';
import 'package:let_tutor/presentation/common_widget/export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:let_tutor/presentation/extentions/extention.dart';
import 'package:let_tutor/presentation/theme/theme_button.dart';
import 'package:let_tutor/presentation/theme/theme_color.dart';

import '../../../route/route_list.dart';
import 'bloc/account_bloc.dart';

part 'account.action.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends StateBase<AccountScreen> {
  late AppLocalizations trans;

  @override
  Widget build(BuildContext context) {
    trans = translate(context);

    return ScreenForm(
      showBackButton: false,
      title: trans.account,
      trans: trans,
      headerColor: AppColor.primaryColor,
      showHeaderImage: false,
      child: BlocConsumer<AccountBloc, AccountState>(
        builder: (context, state) {
          return Container(
            child: ThemeButton.primary(
              context: context,
              title: 'Log out',
              onPressed: logout,
            ),
          );
        },
        listener: _blocListener,
      ),
    );
  }

  @override
  AccountBloc? get bloc => BlocProvider.of(context);
}
