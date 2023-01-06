import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:let_tutor/data/models/payment.dart';
import 'package:let_tutor/presentation/common_widget/export.dart';

import '../../../../generated/assets.dart';
import '../../../base/base.dart';
import '../../../common_widget/smart_refresher_wrapper.dart';
import '../../../extentions/extention.dart';
import '../../../theme/theme_button.dart';
import '../../../theme/theme_color.dart';
import '../bloc/histories_bloc.dart';

part 'histories.action.dart';

class HistoriesScreen extends StatefulWidget {
  const HistoriesScreen({Key? key}) : super(key: key);

  @override
  State<HistoriesScreen> createState() => _HistoriesScreenState();
}

class _HistoriesScreenState extends StateBase<HistoriesScreen> {
  final controller = RefreshController(initialRefresh: true);

  @override
  HistoriesBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  late AppLocalizations trans;

  @override
  void hideLoading() {
    controller
      ..refreshCompleted()
      ..loadComplete();
    super.hideLoading();
  }

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    trans = translate(context);
    return BlocConsumer<HistoriesBloc, HistoriesState>(
      listener: _blocListener,
      builder: (context, state) {
        return ScreenForm(
          headerColor: AppColor.primaryColor,
          bgColor: AppColor.scaffoldColor,
          showHeaderImage: false,
          showBackButton: false,
          trans: trans,
          title: trans.history,
          child: SmartRefresherWrapper.build(
            controller: controller,
            enablePullUp: state.canLoadMore,
            onRefresh: onRefresh,
            onLoading: onLoading,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ..._buildListing(state),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitle() {
    return Center(
      child: Column(
        children: [
          SvgPicture.asset(
            Assets.svg.icCall,
            width: 100,
            height: 100,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            trans.history,
            style: textTheme.bodyText1?.copyWith(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildListing(HistoriesState state) {
    final bookings = state.bookings;
    return [
      _buildTitle(),
      if (bookings.isEmpty) ...[
        const SizedBox(
          height: 32,
        ),
        SvgPicture.asset(
          Assets.svg.icEmptySchedule,
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          trans.noSession,
          style: textTheme.bodyText2?.copyWith(fontSize: 14),
        ),
      ],
      ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => BookingInfoItem(
          booking: bookings.elementAt(index),
          textTheme: textTheme,
          trans: trans,
          onTapRating: () => onTapRating(bookings.elementAt(index)),
          onTapReport: () => onTapReport(bookings.elementAt(index)),
          isDone: true,
        ),
        itemCount: bookings.length,
        separatorBuilder: (context, index) => const SizedBox(
          height: 8,
        ),
      ),
    ];
  }

  Widget _buildRating(Color color) {
    return Icon(
      Icons.star,
      color: color,
      size: 30,
    );
  }
}
