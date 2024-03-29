import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:let_tutor/data/models/course.dart';
import 'package:let_tutor/domain/entities/courses_filter.entity.dart';
import 'package:let_tutor/generated/assets.dart';
import 'package:let_tutor/presentation/common_widget/course_item.dart';
import 'package:let_tutor/presentation/common_widget/export.dart';
import 'package:let_tutor/presentation/common_widget/smart_refresher_wrapper.dart';
import 'package:let_tutor/presentation/route/route_list.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../common/utils/debouncer.dart';
import '../../../base/base.dart';
import '../../../common_widget/tab_page_widget.dart';
import '../../../extentions/extention.dart';
import '../../../theme/theme_color.dart';
import '../bloc/courses_bloc.dart';

part 'courses.action.dart';
part 'pages/courses_page.dart';
part 'pages/ebooks_page.dart';
part 'pages/interactive_ebooks_page.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen() : super();

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends StateBase<CoursesScreen> {
  final _pageController = PageController();
  final _coursesRefreshController = RefreshController();
  final _eBooksRefreshController = RefreshController();
  final _interactiveEBooksRefreshController = RefreshController();

  final _coursesSearch = InputContainerController();
  final _eBooksSearch = InputContainerController();
  final _interactiveEBooksSearch = InputContainerController();

  late final Debouncer _coursesDebouncer;
  late final Debouncer _eBooksDebouncer;
  late final Debouncer _interactiveDebouncer;

  @override
  CoursesBloc get bloc => BlocProvider.of(context);

  late ThemeData _themeData;

  TextTheme get textTheme => _themeData.textTheme;

  late AppLocalizations trans;

  @override
  void initState() {
    super.initState();
    _coursesDebouncer = Debouncer<String>(
      const Duration(milliseconds: 500),
      _getCoursesSearch,
    );
    _eBooksDebouncer = Debouncer<String>(
      const Duration(milliseconds: 500),
      _getEBooksSearch,
    );
    _interactiveDebouncer = Debouncer<String>(
      const Duration(milliseconds: 500),
      _getInteractiveEBooksSearch,
    );
  }

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    trans = translate(context);
    return BlocConsumer<CoursesBloc, CoursesState>(
      listener: _blocListener,
      builder: (context, state) {
        return ScreenForm(
          actions: [
            IconButton(
              onPressed: onTapFilter,
              icon: Icon(
                Icons.filter_alt,
                color: AppColor.white,
              ),
            ),
          ],
          headerColor: AppColor.primaryColor,
          bgColor: AppColor.scaffoldColor,
          showHeaderImage: false,
          showBackButton: false,
          trans: trans,
          title: trans.courses,
          child: _buildCoursesPage(
            state,
          ),
        );
      },
    );
  }

  Widget _buildCoursesPage(CoursesState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TabBox(
          child: DefaultTabController(
            length: 3,
            child: TabBar(
              onTap: _pageController.jumpToPage,
              labelColor: AppColor.primaryColor,
              unselectedLabelColor: AppColor.gray8C,
              isScrollable: true,
              tabs: [
                Tab(text: trans.courses),
                Tab(text: trans.eBook),
                Tab(text: trans.interactiveEBook)
              ],
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
                _buildCoursePage(state),
                _buildEBooksPage(state),
                _buildInteractiveEBooksPage(state),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildSearch({
    required InputContainerController controller,
    required Debouncer debouncer,
    required String hint,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InputContainer(
        fillColor: AppColor.white,
        controller: controller,
        hint: hint,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        onTextChanged: (text) {
          debouncer.value = text;
        },
        suffixIcon: InkWell(
            onTap: () {
              controller.setText = '';
              debouncer.value = '';
            },
            child: Icon(Icons.clear)),
        suffixIconPadding: const EdgeInsets.only(
          right: 14,
          left: 12,
        ),
        onSubmitted: (p0) => debouncer.value = p0,
      ),
    );
  }
}
