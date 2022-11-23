import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:let_tutor/data/models/user.dart';
import 'package:let_tutor/presentation/common_widget/export.dart';
import 'package:let_tutor/presentation/common_widget/smart_refresher_wrapper.dart';

import '../../../../generated/assets.dart';
import '../../../base/base.dart';
import '../../../common_widget/menu_item_widget.dart';
import '../../../extentions/extention.dart';
import '../../../route/route_list.dart';
import '../../../theme/theme_color.dart';
import 'bloc/account_bloc.dart';

part 'account.action.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends StateBase<AccountScreen> {
  final _refreshController = RefreshController(initialRefresh: true);

  @override
  AccountBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  late AppLocalizations trans;

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    trans = translate(context);
    return BlocConsumer<AccountBloc, AccountState>(
      listener: _blocListener,
      builder: (context, state) {
        return SmartRefresherWrapper.build(
          controller: _refreshController,
          onRefresh: onRefresh,
          child: ScreenForm(
            headerColor: AppColor.primaryColor,
            title: trans.account,
            showHeaderImage: false,
            showBackButton: false,
            trans: trans,
            bgColor: AppColor.scaffoldColor,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  _buildAppBar(state),
                  const SizedBox(
                    height: 20,
                  ),
                  _settingItem(
                    divider: ItemDivider.line,
                    itemBorder: ItemBorder.top,
                    iconPath: Assets.svg.icPerson,
                    title: trans.account,
                    callback: onProfile,
                  ),
                  _settingItem(
                    divider: ItemDivider.line,
                    itemBorder: ItemBorder.none,
                    iconPath: Assets.svg.icBookMedical,
                    title: trans.buyLessons,
                    callback: () {
                      _refreshController
                        ..refreshCompleted()
                        ..loadComplete();
                    },
                  ),
                  _settingItem(
                    divider: ItemDivider.line,
                    itemBorder: ItemBorder.none,
                    iconPath: Assets.svg.icChalkboardTeacher,
                    title: trans.tutor,
                    callback: () {},
                  ),
                  _settingItem(
                    divider: ItemDivider.line,
                    itemBorder: ItemBorder.none,
                    iconPath: Assets.svg.icBookOpen,
                    title: trans.myCourses,
                    callback: () {},
                  ),
                  _settingItem(
                    divider: ItemDivider.line,
                    itemBorder: ItemBorder.bottom,
                    iconPath: Assets.svg.icUserGraduate,
                    title: trans.becomeATutor,
                    callback: () {},
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  _settingItem(
                    divider: ItemDivider.line,
                    itemBorder: ItemBorder.top,
                    iconPath: Assets.svg.icSettings,
                    title: trans.settings,
                    callback: () {},
                  ),
                  _settingItem(
                    divider: ItemDivider.line,
                    itemBorder: ItemBorder.bottom,
                    iconPath: Assets.svg.icLogout,
                    title: trans.logout,
                    callback: () {
                      logout();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

   
  }

  Widget _settingItem({
    required String iconPath,
    required String title,
    final Widget? description,
    final ItemDivider? divider = ItemDivider.none,
    final ItemBorder itemBorder = ItemBorder.none,
    final Widget? tailIcon,
    final void Function()? callback,
  }) {
    return MenuItemWidget(
      description: description,
      onTap: () {
        callback?.call();
      },
      divider: divider,
      itemBorder: itemBorder,
      title: title,
      tailIcon: tailIcon ??
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColor.primaryColor,
            size: 16,
          ),
      icon: SvgPicture.asset(
        iconPath,
        width: 24,
        height: 24,
        color: AppColor.primaryColor,
      ),
    );
  }

  Widget _buildAppBar(AccountState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: CachedNetworkImageWrapper.avatar(
              url: state.viewModel.user?.avatar ?? '',
              width: 60,
              height: 60,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            state.user?.name ?? '--',
            style: textTheme.bodyText1,
          ),
          const SizedBox(height: 4),
          Text(
            state.user?.phoneNumber ?? '--',
            style: textTheme.bodyText2?.copyWith(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
