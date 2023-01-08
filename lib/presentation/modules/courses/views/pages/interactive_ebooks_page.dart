part of '../courses_screen.dart';

extension InteractiveEBooksPage on _CoursesScreenState {
  Widget _buildInteractiveEBooksPage(CoursesState state) {
    final books = state.interactiveEBooks;
    final itemW = (device.width - 16 * 2) / 2;
    final aspectRatio = 167 / 187;
    final imageH = itemW / aspectRatio;
    return SmartRefresherWrapper.build(
      controller: _interactiveEBooksRefreshController,
      onRefresh: onInteractiveEBooksRefresh,
      onLoading: onInteractiveEBooksLoading,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: CustomScrollView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: _buildSearch(
                controller: _interactiveEBooksSearch,
                debouncer: _interactiveDebouncer,
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
                          onTap: (e) {},
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
                  ))
          ],
        ),
      ),
    );
  }
}
