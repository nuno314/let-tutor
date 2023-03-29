import 'package:let_tutor/data/models/teacher.dart';

import '../../../../../data/models/payment.dart';
import '../../../../../domain/entities/tutor_list_filter.entity.dart';

enum HomePageStatus {
  initial,
  loading,
  success,
  error,
  filterChanged,
  loadMore,
  loadMoreError
}

class HomePageState {
  final HomePageStatus status;
  final bool canLoadMore;
  final List<Teacher> tutors;
  final TutorListFilter filter;
  final BookingInfo? upcomingLesson;

  const HomePageState({
    this.status = HomePageStatus.initial,
    this.canLoadMore = false,
    this.tutors = const [],
    this.filter = const TutorListFilter(),
    this.upcomingLesson,
  });

  HomePageState copyWith({
    HomePageStatus? status,
    bool? canLoadMore,
    List<Teacher>? tutors,
    TutorListFilter? filter,
    BookingInfo? upcomingLesson,
  }) =>
      HomePageState(
        status: status ?? this.status,
        canLoadMore: canLoadMore ?? this.canLoadMore,
        tutors: tutors ?? this.tutors,
        filter: filter ?? this.filter,
        upcomingLesson: upcomingLesson ?? this.upcomingLesson,
      );
}
