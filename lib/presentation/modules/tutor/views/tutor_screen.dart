import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:let_tutor/data/data_source/remote/app_api_service.dart';
import 'package:let_tutor/data/models/schedule.dart';
import 'package:let_tutor/di/di.dart';
import 'package:let_tutor/presentation/common_widget/schedule_item.dart';
import 'package:let_tutor/presentation/modules/tutor/views/payment/payment_screen.dart';
import 'package:video_player/video_player.dart';

import 'package:let_tutor/common/utils.dart';
import 'package:let_tutor/domain/entities/schedule_filter.entity.dart';
import 'package:let_tutor/presentation/common_widget/export.dart';
import 'package:let_tutor/presentation/route/route_list.dart';

import '../../../../common/constants.dart';
import '../../../../data/models/teacher.dart';
import '../../../base/base.dart';
import '../../../common_widget/box_color.dart';
import '../../../common_widget/controls_overlay.dart';
import '../../../common_widget/smart_refresher_wrapper.dart';
import '../../../common_widget/tab_page_widget.dart';
import '../../../extentions/extention.dart';
import '../../../theme/theme_color.dart';
import '../bloc/tutor_bloc.dart';

part 'pages/booking_screen.dart';
part 'pages/tutor_detail_screen.dart';
part 'tutor.action.dart';

class TutorArgs {
  String? tutorId;
  Teacher? tutor;
  TutorArgs({
    this.tutorId,
    this.tutor,
  });
}

class TutorScreen extends StatefulWidget {
  final TutorArgs args;
  const TutorScreen({Key? key, required this.args}) : super(key: key);

  @override
  State<TutorScreen> createState() => _TutorScreenState();
}

class _TutorScreenState extends StateBase<TutorScreen> {
  final _pageController = PageController();
  final infoRefreshController = RefreshController();
  final bookingRefreshController = RefreshController(initialRefresh: true);

  @override
  TutorBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  late AppLocalizations trans;

  Teacher get tutor => bloc.state.tutor ?? widget.args.tutor!;

  @override
  void hideLoading() {
    infoRefreshController
      ..refreshCompleted()
      ..loadComplete();
    bookingRefreshController
      ..refreshCompleted()
      ..loadComplete();

    super.hideLoading();
  }

  final refreshController = RefreshController(initialRefresh: false);
  late VideoPlayerController vpController;

  @override
  void initState() {
    vpController = VideoPlayerController.network(
      tutor.video ?? '',
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );
    vpController.addListener(() {});
    vpController.setLooping(true);
    vpController.initialize();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    trans = translate(context);
    return BlocConsumer<TutorBloc, TutorState>(
      listener: _blocListener,
      builder: (context, state) {
        return ScreenForm(
          headerColor: AppColor.primaryColor,
          bgColor: AppColor.scaffoldColor,
          title: trans.tutor.capitalizeFirstofEach(),
          showHeaderImage: false,
          trans: trans,
          child: _buildTutorPage(state),
        );
      },
    );
  }

  Widget _buildTutorPage(TutorState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TabBox(
          child: DefaultTabController(
            length: 2,
            child: TabBar(
              onTap: _pageController.jumpToPage,
              labelColor: AppColor.primaryColor,
              unselectedLabelColor: AppColor.gray8C,
              tabs: [Tab(text: trans.detail), Tab(text: trans.book)],
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: AppColor.white,
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              allowImplicitScrolling: true,
              children: [
                _buildTutorInfoPage(state),
                _buildBookingPage(state),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    vpController.dispose();
    super.dispose();
  }
}
