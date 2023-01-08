part of '../courses_screen.dart';

extension EBooksPage on _CoursesScreenState {
  Widget _buildEBooksPage(CoursesState state) {
    final books = state.eBooks;
    final itemW = (device.width - 16 * 2) / 2;
    final aspectRatio = 167 / 187;
    final imageH = itemW / aspectRatio;
    return SmartRefresherWrapper.build(
      controller: _eBooksRefreshController,
      onRefresh: onEBooksRefresh,
      onLoading: onEBooksLoading,
      enablePullUp: state.canLoadMoreEBooks,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: CustomScrollView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: _buildSearch(
                controller: _eBooksSearch,
                debouncer: _eBooksDebouncer,
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
                          onTap: onTapBook,
                          viewNowText: trans.seeNow,
                          isBook: true,
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
