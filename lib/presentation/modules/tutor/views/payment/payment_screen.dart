import 'package:flutter/material.dart';
import 'package:let_tutor/common/utils.dart';
import 'package:let_tutor/data/models/payment.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:let_tutor/data/models/schedule.dart';
import 'package:let_tutor/data/models/teacher.dart';
import 'package:let_tutor/presentation/common_widget/input_container/input_container.dart';
import 'package:let_tutor/presentation/theme/shadow.dart';
import 'package:let_tutor/presentation/theme/theme_button.dart';
import 'package:sprintf/sprintf.dart';

import '../../../../common_widget/forms/screen_form.dart';
import '../../../../extentions/extention.dart';
import '../../../../theme/theme_color.dart';

class PaymentArgs {
  final Wallet wallet;
  final Schedule schedule;
  final Teacher tutor;

  PaymentArgs({
    required this.wallet,
    required this.schedule,
    required this.tutor,
  });
}

class PaymentResult {
  final bool res;
  final String? note;

  PaymentResult(this.res, this.note);
}

class PaymentScreen extends StatefulWidget {
  final PaymentArgs args;
  const PaymentScreen({required this.args});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final controller = InputContainerController();
  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  late AppLocalizations trans;

  Schedule get schedule => widget.args.schedule;
  Wallet get wallet => widget.args.wallet;

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    trans = translate(context);
    return ScreenForm(
      headerColor: AppColor.primaryColor,
      bgColor: AppColor.scaffoldColor,
      title: trans.payment,
      showHeaderImage: false,
      trans: trans,
      child: _buildListing(),
    );
  }

  Widget _buildListing() {
    final widgets = [
      _buildScheduleInfo(),
      const SizedBox(
        height: 12,
      ),
      _buildWalletInfo(),
      const SizedBox(
        height: 12,
      ),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child:
          CustomScrollView(physics: NeverScrollableScrollPhysics(), slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => widgets.elementAt(index),
            childCount: widgets.length,
          ),
        ),
        SliverFillRemaining(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: ThemeButton.outline(
                    context: context,
                    title: trans.cancel,
                    padding: const EdgeInsets.all(0),
                    onPressed: () => Navigator.pop(
                      context,
                      PaymentResult(
                        false,
                        controller.text,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: ThemeButton.primary(
                    context: context,
                    title: trans.payment,
                    padding: const EdgeInsets.all(0),
                    onPressed: () =>
                        wallet.amount.isNotNullOrEmpty && wallet.amount != '0'
                            ? Navigator.pop(
                                context,
                                PaymentResult(
                                  true,
                                  controller.text,
                                ),
                              )
                            : showNoticeDialog(
                                context: context,
                                message: trans.insufficientBalance,
                                title: trans.payment,
                                titleBtn: trans.confirm,
                              ),
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildScheduleInfo() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: boxShadowlight,
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                trans.bookingTime,
                style: textTheme.bodyText1,
              ),
              Text(
                widget.args.tutor.name!,
                style: textTheme.bodyText1?.copyWith(color: AppColor.green),
              ),
            ],
          ),
          Divider(
            height: 12,
            thickness: 1,
          ),
          Text(
            DateTime.fromMillisecondsSinceEpoch(
                  schedule.startPeriodTimestamp ?? 0,
                ).toLocal().toTimeFormat() +
                ' - ' +
                DateTime.fromMillisecondsSinceEpoch(
                  schedule.endPeriodTimestamp ?? 0,
                ).toLocal().toTimeFormat() +
                ' ' +
                DateTime.fromMillisecondsSinceEpoch(
                  schedule.startPeriodTimestamp ?? 0,
                ).toLocal().toDateWithWeekdayFormat(context),
            style: textTheme.bodyText2?.copyWith(
              fontSize: 12,
              color: AppColor.gray8C,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWalletInfo() {
    final amount = wallet.amount ?? '';
    return Container(
      decoration: BoxDecoration(
        boxShadow: boxShadowlight,
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            trans.myWallet,
            style: textTheme.bodyText1,
          ),
          Divider(
            height: 12,
            thickness: 1,
          ),
          Row(
            children: [
              Text(
                trans.balance,
                style: textTheme.bodyText2?.copyWith(
                  fontSize: 14,
                ),
              ),
              Expanded(
                child: Text(
                  sprintf(
                    trans.youHaveLessonsLeft,
                    [
                      wallet.amount?.substring(
                              0,
                              amount.length > 100000
                                  ? amount.length - 5
                                  : amount.length) ??
                          ''
                    ],
                  ),
                  textAlign: TextAlign.right,
                  style: textTheme.bodyText2?.copyWith(
                    fontSize: 14,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Text(
                trans.price,
                style: textTheme.bodyText2?.copyWith(
                  fontSize: 14,
                ),
              ),
              Expanded(
                child: Text(
                  '1 ' + trans.lesson,
                  textAlign: TextAlign.right,
                  style: textTheme.bodyText2?.copyWith(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          InputContainer(
            controller: controller,
            title: trans.notes,
            titleStyle: textTheme.bodyText1,
            fillColor: AppColor.white,
            maxLines: 5,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 6,
              horizontal: 8,
            ),
          ),
        ],
      ),
    );
  }
}
