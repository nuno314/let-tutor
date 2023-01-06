part of '../courses_screen.dart';

extension CoursesPage on _CoursesScreenState {
  Widget _buildCoursePage(CoursesState state) {
    final books = state.courses;

    return SmartRefresherWrapper.build(
      controller: _coursesRefreshController,
      onRefresh: onCoursesRefresh,
      onLoading: onCoursesLoading,
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
