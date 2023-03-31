import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:let_tutor/presentation/modules/main/home_page/home_page_screen.dart';
import 'package:let_tutor/presentation/modules/schedule/views/schedule_screen.dart';

import '../../../../generated/assets.dart';
import '../../../base/base.dart';
import '../../../common_widget/after_layout.dart';
import '../../../common_widget/custom_bottom_navigation_bar.dart';
import '../../../common_widget/keep_alive_widget.dart';
import '../../../common_widget/smart_image.dart';
import '../../../extentions/extention.dart';
import '../../../theme/theme_color.dart';
import '../../courses/courses.dart';
import '../../histories/histories.dart';
import '../account/account_screen.dart';
import '../account/bloc/account_bloc.dart';
import 'cubit/dashboard_cubit.dart';
import 'dashboard_constant.dart';

part 'dashboard.action.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends StateBase<DashboardScreen>
    with AfterLayoutMixin, WidgetsBindingObserver {
  DashboardCubit get _cubit => BlocProvider.of(context);

  final _pageController = PageController();

  @override
  void afterFirstLayout(BuildContext context) {
    // syncData();
    _cubit.navigateTo(DashboardPage.home.index);
    // ..markLaunched();
  }

  @override
  void initState() {
    // WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _didChangeAppLifecycleState(state);
  }

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  late AppLocalizations trans;

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    trans = translate(context);
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom + 65,
            ),
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: [
                KeepAliveWidget(
                  child: const HomePageScreen(),
                ),
                KeepAliveWidget(
                  child: ScheduleScreen(),
                ),
                KeepAliveWidget(
                  child: HistoriesScreen(),
                ),
                KeepAliveWidget(
                  child: BlocProvider(
                    create: (context) => CoursesBloc(),
                    child: const CoursesScreen(),
                  ),
                ),
                KeepAliveWidget(
                  child: BlocProvider(
                    create: (context) => AccountBloc(),
                    child: const AccountScreen(),
                  ),
                ),
              ],
            ),
          ),
          BlocConsumer<DashboardCubit, DashboardState>(
            listener: _cubitListener,
            bloc: _cubit,
            builder: (context, state) => CustomBottomNavigationBar(
              items: [
                BottomBarItemData(
                  label: trans.tutor,
                  icon: _buildBottomBarIcon(
                    icon: Assets.svg.icChalkboardTeacher,
                    select: false,
                  ),
                  selectedIcon: _buildBottomBarIcon(
                    icon: Assets.svg.icChalkboardTeacher,
                    select: true,
                  ),
                ),
                BottomBarItemData(
                  label: trans.schedule,
                  icon: _buildBottomBarIcon(
                    icon: Assets.svg.icSchedule,
                    select: false,
                  ),
                  selectedIcon: _buildBottomBarIcon(
                    icon: Assets.svg.icSchedule,
                    select: true,
                  ),
                ),
                BottomBarItemData(
                  label: trans.history,
                  icon: _buildBottomBarIcon(
                    icon: Assets.svg.icHistory,
                    select: false,
                  ),
                  selectedIcon: _buildBottomBarIcon(
                    icon: Assets.svg.icHistory,
                    select: true,
                  ),
                ),
                BottomBarItemData(
                  label: trans.courses,
                  icon: _buildBottomBarIcon(
                    icon: Assets.svg.icGraduationCap,
                    select: false,
                  ),
                  selectedIcon: _buildBottomBarIcon(
                    icon: Assets.svg.icGraduationCap,
                    select: true,
                  ),
                ),
                BottomBarItemData(
                  label: trans.account,
                  icon: _buildBottomBarIcon(
                    icon: Assets.svg.icPerson,
                    select: false,
                  ),
                  selectedIcon: _buildBottomBarIcon(
                    icon: Assets.svg.icPerson,
                    select: true,
                  ),
                ),
              ],
              selectedIdx: state.index,
              onItemSelection: onNavigationPressed,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBarIcon({
    required String icon,
    required bool select,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      constraints: const BoxConstraints(
        maxHeight: 40,
        maxWidth: 40,
        minHeight: 40,
        minWidth: 40,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: !select
            ? null
            : const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [0.0, 0.5, 1],
                colors: [
                  Color(0xffF89E7F8),
                  Color(0xffA2DEF6),
                  Color(0xff8AD6F4),
                ],
              ),
      ),
      alignment: Alignment.center,
      child: SmartImage(
        image: icon,
        width: 20,
        height: 20,
        color: select ? Colors.white : const Color(0xff8C8C8C),
      ),
    );
  }

  @override
  AppBlocBase? get bloc => null;
}
