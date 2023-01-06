part of '../courses_screen.dart';

extension EBooksPage on _CoursesScreenState {
  Widget _buildEBooksPage(CoursesState state) {
    final books = state.eBooks;

    return SmartRefresherWrapper.build(
      controller: _coursesRefreshController,
      onRefresh: onEBooksRefresh,
      onLoading: onEBooksLoading,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomScrollView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          slivers: [],
        ),
      ),
    );
  }
}
