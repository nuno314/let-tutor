import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/presentation/base/base.dart';
import 'package:let_tutor/presentation/theme/theme_button.dart';

import '../../../route/route_list.dart';
import 'bloc/account_bloc.dart';

part 'account.action.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends StateBase<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountBloc, AccountState>(
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
    );
  }

  @override
  AccountBloc? get bloc => BlocProvider.of(context);

}
