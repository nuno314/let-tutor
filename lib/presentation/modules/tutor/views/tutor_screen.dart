import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../base/base.dart';
import '../../../common_widget/smart_refresher_wrapper.dart';
import '../../../extentions/extention.dart';
import '../bloc/tutor_bloc.dart';

part 'tutor.action.dart';

class TutorScreen extends StatefulWidget {
  const TutorScreen({Key? key}) : super(key: key);

  @override
  State<TutorScreen> createState() => _TutorScreenState();
}

class _TutorScreenState extends StateBase<TutorScreen> {
  final _refreshController = RefreshController(initialRefresh: true);

  @override
  TutorBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  late AppLocalizations trans;

  @override
  void hideLoading() {
    _refreshController
      ..refreshCompleted()
      ..loadComplete();
    super.hideLoading();
  }

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    trans = translate(context);
    return BlocConsumer<TutorBloc, TutorState>(
      listener: _blocListener,
      builder: (context, state) {
        return _buildListing(state);
      },
    );
  }

  Widget _buildListing(TutorState state) {
    return SmartRefresherWrapper.build(
      enablePullDown: true,
      enablePullUp: state.viewModel.canLoadMore,
      onLoading: loadMore,
      onRefresh: onRefresh,
      controller: _refreshController,
      child: ListView.separated(
        itemBuilder: (context, index) {
          return const SizedBox();
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
        itemCount: state.viewModel.data.length,
      ),
    );
  }
}
