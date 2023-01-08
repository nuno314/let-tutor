part of '../courses_screen.dart';

extension EBooksPage on _CoursesScreenState {
  Widget _buildEBooksPage(CoursesState state) {
    print(state.canLoadMoreEBooks);
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
