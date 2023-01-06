part of '../courses_screen.dart';

extension InteractiveEBooksPage on _CoursesScreenState {
  Widget _buildInteractiveEBooksPage(CoursesState state) {
    final books = state.interactiveEBooks;

    return SmartRefresherWrapper.build(
      controller: _coursesRefreshController,
      onRefresh: onInteractiveEBooksRefresh,
      onLoading: onInteractiveEBooksLoading,
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
