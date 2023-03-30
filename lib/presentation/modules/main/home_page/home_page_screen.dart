import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:let_tutor/data/models/payment.dart';
import 'package:let_tutor/data/models/teacher.dart';
import 'package:let_tutor/domain/entities/tutor_list_filter.entity.dart';
import 'package:let_tutor/generated/assets.dart';
import 'package:let_tutor/presentation/modules/main/home_page/provider/home_page_provider.dart';

import 'package:let_tutor/presentation/route/route_list.dart';
import 'package:let_tutor/presentation/theme/theme_color.dart';

import '../../../../common/utils.dart';
import '../../../common_widget/export.dart';
import '../../../common_widget/smart_refresher_wrapper.dart';
import '../../../common_widget/teacher_item.dart';
import '../../../extentions/extention.dart';
import '../../tutor/views/tutor_screen.dart';
import 'provider/home_page_state.dart';

part 'home_page.action.dart';

class HomePageScreen extends ConsumerStatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends ConsumerState<HomePageScreen> {
  final _refreshController = RefreshController(initialRefresh: true);
  final _searchController = InputContainerController();

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  late AppLocalizations trans;

  late DateTime dateTime = DateTime.now().add(Duration(days: 1));

  final tutorNotifier = ValueNotifier<String?>(null);

  late Debouncer _debouncer;

  late HomePageProvider provider;

  void initState() {
    _debouncer = Debouncer<String>(const Duration(milliseconds: 500), search);
    provider = ref.read(homePageProvider.notifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    trans = translate(context);
    final state = ref.watch(homePageProvider);

    return ScreenForm(
      trans: trans,
      showBackButton: false,
      resizeToAvoidBottomInset: false,
      extentions: const SizedBox(
        height: 10,
      ),
      actions: [
        IconButton(
          onPressed: () => onTapTutorFilter(state),
          icon: Icon(
            Icons.filter_alt,
            color: AppColor.primaryColor,
          ),
        )
      ],
      child: SmartRefresherWrapper.build(
          controller: _refreshController,
          onRefresh: onRefresh,
          onLoading: onLoading,
          enablePullUp: state.canLoadMore,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: _buildListing(state),
            ),
          )),
      floatingActionButton: IconButton(
        constraints: const BoxConstraints(minHeight: 84, minWidth: 84),
        icon: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            color: AppColor.grayAD,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.chat_outlined,
            color: AppColor.white,
            size: 40,
          ),
        ),
        onPressed: () {},
      ),
    );
  }

  List<Widget> _buildListing(HomePageState state) {
    return [
      _buildBanner(state.upcomingLesson),
      _buildTutorList(state),
    ];
  }

  Widget _buildBanner(BookingInfo? info) {
    String from, to, date = '', period = '';
    if (info != null) {
      date = DateTime.fromMillisecondsSinceEpoch(
        info.schedule!.startPeriodTimestamp ?? 0,
      ).toDateWithWeekdayFormat(context);
      from = DateTime.fromMicrosecondsSinceEpoch(
        info.schedule!.startPeriodTimestamp ?? 0,
      ).toTimeFormat();
      to = DateTime.fromMicrosecondsSinceEpoch(
        info.schedule!.endPeriodTimestamp ?? 0,
      ).toTimeFormat();
      period = from + ' - ' + to;
    }

    return Container(
      height: 230,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(12, 61, 223, 1),
            Color.fromRGBO(5, 23, 157, 1),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            info != null ? trans.upcomingLesson : trans.youHaveNoUpcomingLesson,
            style: textTheme.bodyLarge?.copyWith(
              fontSize: 18,
              color: AppColor.white,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          if (info != null) ...[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        date,
                        style: textTheme.bodyLarge?.copyWith(
                          color: AppColor.white,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        period,
                        style: textTheme.bodyMedium?.copyWith(
                          color: AppColor.white,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: AppColor.white,
                      ),
                      height: 60,
                      child: InkWell(
                        child: Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: CachedNetworkImageWrapper.avatar(
                                  url: info.schedule?.tutorInfo?.avatar ?? '',
                                  height: 24,
                                  width: 24,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      Assets.svg.icYoutube,
                                      width: 24,
                                      color: AppColor.red,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Text(
                                        trans.enterLessonRoom,
                                        style: textTheme.bodyLarge?.copyWith(
                                          color: AppColor.red,
                                          fontSize: 12,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTutorList(HomePageState state) {
    final tutors = state.tutors;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 16,
          ),
          _buildTutorSearch(),
          SizedBox(
            height: 16,
          ),
          Text(
            trans.recommendedTutors,
            style: textTheme.bodyLarge?.copyWith(
              fontSize: 14,
            ),
          ),
          ...tutors
              .map((e) => InkWell(
                    onTap: () => onTapBookCourse(e),
                    child: TeacherItem(
                      onTapFavorite: () => onTapTutorFavorite(e),
                      teacher: e,
                      textTheme: textTheme,
                    ),
                  ))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildTutorSearch() {
    return InputContainer(
      title: trans.findATutor,
      controller: _searchController,
      titleStyle: textTheme.bodyLarge?.copyWith(
        fontSize: 14,
      ),
      fillColor: AppColor.white,
      onTextChanged: ((p0) => _debouncer.value = p0),
      suffixIcon: InkWell(
          onTap: () {
            _searchController.setText = '';
            _debouncer.value = '';
          },
          child: Icon(Icons.clear)),
      suffixIconPadding: const EdgeInsets.only(
        right: 14,
        left: 12,
      ),
    );
  }

  void search(String? value) {
    provider.searchTutor(value);
  }
}
