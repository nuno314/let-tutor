part of '../courses_screen.dart';

extension CoursesPage on _CoursesScreenState {
  Widget _buildCoursePage(CoursesState state) {
    final books = state.courses;
    final itemW = (device.width - 16 * 2) / 2;
    final aspectRatio = 167 / 187;
    final imageH = itemW / aspectRatio;
    return SmartRefresherWrapper.build(
      controller: _coursesRefreshController,
      onRefresh: onCoursesRefresh,
      onLoading: onCoursesLoading,
      enablePullUp: state.canLoadMoreCourses,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: CustomScrollView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: _buildSearch(
                controller: _coursesSearch,
                debouncer: _coursesDebouncer,
                hint: trans.searchCourse,
              ),
            ),
            books.isNotEmpty
                ? SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      mainAxisExtent: imageH,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return CourseCard(
                          aspectRatio: 137 / 100,
                          course: books.elementAt(index),
                          themeData: _themeData,
                          onTap: onTapCourse,
                          viewNowText: trans.seeNow,
                        );
                      },
                      childCount: books.length,
                      semanticIndexOffset: 2,
                    ),
                  )
                : SliverToBoxAdapter(
                    child: Center(
                      child: EmptyData(
                        icon: SvgPicture.asset(
                          Assets.svg.icEmptySchedule,
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
