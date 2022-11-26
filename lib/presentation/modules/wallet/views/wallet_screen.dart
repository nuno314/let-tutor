import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:let_tutor/common/constants.dart';
import 'package:let_tutor/presentation/common_widget/export.dart';
import 'package:let_tutor/presentation/common_widget/smart_refresher_wrapper.dart';
import 'package:let_tutor/presentation/theme/shadow.dart';
import 'package:let_tutor/common/utils/date_utils.dart';
import 'package:sprintf/sprintf.dart';

import '../../../../generated/assets.dart';

import '../../../base/base.dart';
import '../../../extentions/extention.dart';
import '../../../theme/theme_color.dart';
import '../bloc/wallet_bloc.dart';

part 'wallet.action.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends StateBase<WalletScreen> {
  final _refreshController = RefreshController(initialRefresh: true);
  @override
  WalletBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  late AppLocalizations trans;

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    trans = translate(context);
    return BlocConsumer<WalletBloc, WalletState>(
      listener: _blocListener,
      builder: (context, state) {
        return SmartRefresherWrapper.build(
          controller: _refreshController,
          onRefresh: onRefresh,
          child: ScreenForm(
            trans: trans,
            title: trans.myWallet,
            showHeaderImage: false,
            bgColor: AppColor.scaffoldColor,
            headerColor: AppColor.primaryColor,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  _buildPaymentStatistic(state),
                  _buildReferral(state),
                  _buildTransactions(state),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPaymentStatistic(WalletState state) {
    if (state.total == null) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 24,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 24,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: boxShadowlight,
                color: AppColor.white,
              ),
              child: Column(
                children: [
                  Text(
                    trans.totalLessons,
                    style: textTheme.bodyText1?.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    state.total!.toString(),
                    style: textTheme.bodyText1?.copyWith(
                      fontSize: 30,
                      color: AppColor.primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    state.firstTime ?? '',
                    style: textTheme.bodyText2?.copyWith(
                      color: AppColor.grayAD,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildReferral(WalletState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 24,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: boxShadowlight,
                color: AppColor.white,
              ),
              child: Column(
                children: [
                  Text(
                    trans.bonus,
                    style: textTheme.bodyText1?.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    '0đ',
                    style: textTheme.bodyText1?.copyWith(
                      fontSize: 30,
                      color: AppColor.primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    sprintf(
                      trans.getCommission,
                      ['5%'],
                    ),
                    style: textTheme.bodyText2?.copyWith(
                      color: AppColor.grayAD,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Divider(
                    height: 32,
                    thickness: 1,
                  ),
                  if (state.referralCode == null) ...[
                    Text(
                      trans.referralCode,
                      style: textTheme.bodyText1?.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    InkWell(
                      onTap: () => onTapReferralCode('awd'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            8,
                          ),
                          color: AppColor.primaryColor,
                        ),
                        child: Text(
                          state.referralCode ?? '7GE98QO8IH',
                          style: textTheme.bodyText1?.copyWith(
                            color: AppColor.white,
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 32,
                      thickness: 1,
                    ),
                  ],
                  Text(
                    trans.yourReferral,
                    style: textTheme.bodyText1?.copyWith(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  if (state.referrals?.isEmpty ?? false) ...[
                    SvgPicture.asset(
                      Assets.svg.icEmptySchedule,
                      height: 100,
                    ),
                    Text(
                      trans.noReferral,
                      style: textTheme.bodyText2?.copyWith(
                        color: AppColor.grayAD,
                        fontSize: 12,
                      ),
                    )
                  ] else
                    Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactions(WalletState state) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 24,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: boxShadowlight,
        color: AppColor.white,
      ),
      child: Column(
        children: [
          Text(
            trans.transactions,
            style: textTheme.bodyText1?.copyWith(
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          if (state.payment == null || state.payment!.isEmpty) ...[
            SvgPicture.asset(
              Assets.svg.icEmptySchedule,
              height: 100,
            ),
            Text(
              trans.noTransaction,
              style: textTheme.bodyText2?.copyWith(
                color: AppColor.grayAD,
                fontSize: 12,
              ),
            )
          ] else ...[
            Column(
              children: state.payment!
                  .map(
                    (e) => Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 4,
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImageWrapper.avatar(
                              url: e.bookingInfo!.schedule!.tutorInfo!.avatar!,
                              width: 50,
                              height: 50,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.bookingInfo!.schedule!.tutorInfo!.name!,
                                style: textTheme.bodyText1,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                e.bookingInfo!.createdAt!
                                    .serverToNormalFullFormat(),
                                style: textTheme.bodyText2?.copyWith(
                                  color: AppColor.grayAD,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 6,
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      e.isBook ? AppColor.green : AppColor.red,
                                ),
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              e.type!.localized(
                                trans,
                              ),
                              style: textTheme.bodyText1?.copyWith(
                                fontSize: 12,
                                color: e.isBook ? AppColor.green : AppColor.red,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                  .toList(),
            )
          ],
        ],
      ),
    );
  }
}
