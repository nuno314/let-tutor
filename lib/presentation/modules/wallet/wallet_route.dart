import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_tutor/presentation/route/route_list.dart';

import 'bloc/wallet_bloc.dart';
import 'views/wallet_screen.dart';

class WalletRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        RouteList.wallet: (context) {
          return BlocProvider(
            create: (context) => WalletBloc(),
            child: const WalletScreen(),
          );
        },
      };
}
