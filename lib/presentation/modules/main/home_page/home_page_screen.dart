import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:let_tutor/data/models/teacher.dart';
import 'package:let_tutor/generated/assets.dart';

import 'package:let_tutor/presentation/base/base.dart';
import 'package:let_tutor/presentation/common_widget/date_picker/cupertino_date_picker_custom.dart';
import 'package:let_tutor/presentation/theme/theme_color.dart';

import '../../../../common/utils.dart';
import '../../../common_widget/export.dart';
import '../../../common_widget/smart_refresher_wrapper.dart';
import '../../../common_widget/teacher_item.dart';
import '../../../extentions/extention.dart';
import 'bloc/home_page_bloc.dart';

part 'home_page.action.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends StateBase<HomePageScreen> {
  final _refreshController = RefreshController(initialRefresh: false);
  ScrollController _controller = new ScrollController();

  @override
  HomePageBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  @override
  late AppLocalizations trans;

  late DateTime dateTime = DateTime.now().add(Duration(days: 1));

  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    trans = translate(context);
    return ScreenForm(
      trans: trans,
      // showHeaderImage: false,
      showBackButton: false,
      child: SmartRefresherWrapper.build(
        enablePullDown: false,
        controller: _refreshController,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: BlocConsumer<HomePageBloc, HomePageState>(
            listener: _blocListener,
            builder: (context, state) {
              return Column(
                children: _buildListing(),
              );
            },
          ),
        ),
      ),
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

  List<Widget> _buildListing() {
    return [
      _buildBanner(),
      _buildTeacherFilter(),
      _buildTeacherList(),
    ];
  }

  Widget _buildBanner() {
    return Container(
      height: 300,
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
              'Buổi học sắp diễn ra',
              style: textTheme.bodyText2?.copyWith(
                fontSize: 30,
                color: AppColor.white,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      dateTime.toLocal().serverToDateOfWeek(
                                context,
                              ) +
                          ' 00:00 - 00:25',
                      style: textTheme.bodyText2?.copyWith(
                        color: AppColor.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: AppColor.white,
                      ),
                      height: 50,
                      child: InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              Assets.svg.icYoutube,
                              width: 30,
                              color: AppColor.primaryColor,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              'Vào lớp học',
                              style: textTheme.bodyText2?.copyWith(
                                color: AppColor.primaryColor,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Tổng số giờ bạn đã học là 156 giờ 15 phút',
              style: textTheme.bodyText2?.copyWith(
                color: AppColor.white,
              ),
              textAlign: TextAlign.center,
            )
          ]),
    );
  }

  Widget _buildTeacherFilter() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tìm kiếm gia sư',
            style: textTheme.bodyText1?.copyWith(
              fontSize: 30,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _buildNameFilter(),
          SizedBox(
            height: 20,
          ),
          _buildStudyFilter(),
          SizedBox(
            height: 20,
          ),
          _buildCategory(),
          Divider(
            height: 50,
            thickness: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildNameFilter() {
    List<String> nationalities = [
      'Gia Sư Nước Ngoài',
      'Gia Sư Việt Nam',
      'Gia Sư Tiếng Anh',
    ];
    var _selected;
    return Row(
      children: [
        Expanded(
          child: InputContainer(
            hint: 'Nhập tên gia sư',
            textStyle: textTheme.bodyText2?.copyWith(
              fontSize: 14,
              color: AppColor.grayAD,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        DropdownButton<String>(
          iconSize: 0,
          hint: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.grayAD),
                borderRadius: BorderRadius.circular(
                  32,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Chọn quốc tịch',
                    style: textTheme.bodyText2?.copyWith(
                      fontSize: 14,
                      color: AppColor.grayAD,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 20,
                    color: AppColor.grayAD,
                  ),
                ],
              )),
          value: _selected,
          items: nationalities
              .map(
                (e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(e),
                ),
              )
              .toList(),
          onChanged: (value) {},
        )
      ],
    );
  }

  Widget _buildStudyFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Chọn thời gian dạy kèm có lịch trống:',
          style: textTheme.bodyText1?.copyWith(
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        InkWell(
          onTap: () {
            showMyCustomDatePicker(
              context,
              DateTime.now(),
              (selectecDate) {},
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 20,
            ),
            width: 170,
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.grayAD),
              borderRadius: BorderRadius.circular(
                32,
              ),
            ),
            child: Row(
              children: [
                Text(
                  'Chọn một ngày',
                  style: textTheme.bodyText2?.copyWith(
                    fontSize: 14,
                    color: AppColor.grayAD,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Icon(
                  Icons.calendar_today_outlined,
                  color: AppColor.grayAD,
                )
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.grayAD),
            borderRadius: BorderRadius.circular(
              32,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Giờ bắt đầu',
                  style: textTheme.bodyText2?.copyWith(
                    fontSize: 14,
                    color: AppColor.grayAD,
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Icon(
                Icons.navigate_next,
                color: AppColor.grayAD,
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  'Giờ kết thúc',
                  style: textTheme.bodyText2?.copyWith(
                    fontSize: 14,
                    color: AppColor.grayAD,
                  ),
                ),
              ),
              Icon(
                Icons.access_time,
                color: AppColor.grayAD,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategory() {
    final categories = [
      'Tất cả',
      'Tiếng Anh cho trẻ em',
      'Tiếng Anh cho công việc',
      'Giao tiếp',
      'STARTERS',
      'MOVERS',
      'FLYERS',
      'KET',
      'IELTS',
      'TOEFL',
      'TOEIC',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: categories
              .map(
                (e) => Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                    color: AppColor.grey64,
                  ),
                  child: Text(e),
                ),
              )
              .toList(),
        ),
        SizedBox(
          height: 12,
        ),
        InkWell(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColor.primaryColor,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text(
              'Đặt lại bộ tìm kiếm',
              style: textTheme.bodyText2?.copyWith(
                color: AppColor.primaryColor,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildTeacherList() {
    final teachers = [
      Teacher(
        name: 'Keegan',
        rating: 5,
        country: 'France',
        avatarUrl:
            'https://api.app.lettutor.com/avatar/4d54d3d7-d2a9-42e5-97a2-5ed38af5789aavatar1627913015850.00',
        description:
            'I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also',
        categories: [
          'Tiếng Anh cho công việc',
          'Giao tiếp',
          'Tiếng Anh cho trẻ em',
          'IELTS',
          'TOEIC'
        ],
      ),
      Teacher(
        name: 'Keegan',
        rating: 5,
        country: 'France',
        avatarUrl:
            'https://api.app.lettutor.com/avatar/4d54d3d7-d2a9-42e5-97a2-5ed38af5789aavatar1627913015850.00',
        description:
            'I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also',
        categories: [
          'Tiếng Anh cho công việc',
          'Giao tiếp',
          'Tiếng Anh cho trẻ em',
          'IELTS',
          'TOEIC'
        ],
      )
    ];
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gia sư được đề xuất',
            style: textTheme.bodyText1?.copyWith(
              fontSize: 20,
            ),
          ),
          ...teachers
              .map((e) => TeacherItem(
                    teacher: e,
                    textTheme: textTheme,
                  ))
              .toList(),
        ],
      ),
    );
  }
}
