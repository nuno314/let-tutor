import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../base/base.dart';
import '../../../common_widget/smart_refresher_wrapper.dart';
import '../../../extentions/extention.dart';
import '../bloc/histories_bloc.dart';

part 'histories.action.dart';

class HistoriesScreen extends StatefulWidget {
  const HistoriesScreen({Key? key}) : super(key: key);

  @override
  State<HistoriesScreen> createState() => _HistoriesScreenState();
}

class _HistoriesScreenState extends StateBase<HistoriesScreen> {
  final _refreshController = RefreshController(initialRefresh: true);

  @override
  HistoriesBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  @override
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
    return BlocConsumer<HistoriesBloc, HistoriesState>(
      listener: _blocListener,
      builder: (context, state) {
        return _buildListing(state);
      },
    );
  }

  Widget _buildListing(HistoriesState state) {
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
