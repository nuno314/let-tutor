import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:let_tutor/common/utils.dart';
import 'package:let_tutor/data/models/teacher.dart';
import 'package:let_tutor/presentation/modules/main/home_page/provider/home_page_state.dart';

import '../../../../../domain/entities/pagination.entity.dart';
import '../../../../../domain/entities/tutor_list_filter.entity.dart';
import '../repository/home_page_repository.dart';

final homePageProvider = StateNotifierProvider<HomePageProvider, HomePageState>(
    (ref) => HomePageProvider(ref.read(homePageRepositoryProvider)));

class HomePageProvider extends StateNotifier<HomePageState> {
  final HomePageRepository repository;

  HomePageProvider(this.repository) : super(const HomePageState());

  Pagination pagination = Pagination();

  Future<void> initialData() async {
    await getNextBookingSchedule();
    await getTutorList();
  }

  Future<void> getNextBookingSchedule() async {
    final upcomingLesson =
        await repository.getNextBookingSchedule(DateTime.now());
    state = state.copyWith(
      upcomingLesson: upcomingLesson.firstOrNull,
    );
  }

  Future<void> getTutorList() async {
    pagination = Pagination();
    final tutorList = await repository.getTutorList(
      page: pagination.firstPage,
      perPage: pagination.limit,
      filter: state.filter.where,
    );
    final length = tutorList.length;
    pagination = Pagination(
      offset: pagination.total,
      total: pagination.total + length,
    );
    state = state.copyWith(
      status: HomePageStatus.success,
      tutors: tutorList,
      canLoadMore: pagination.canNext,
    );
  }

  Future<void> loadMoreTutorList() async {
    final tutors = <Teacher>[];

    final moreData = await repository.getTutorList(
      page: pagination.currentPage,
      perPage: pagination.limit,
      filter: state.filter.where,
    );

    tutors.addAll(moreData);

    pagination = Pagination(
      offset: pagination.total,
      total: pagination.total + tutors.length,
    );
    state = state.copyWith(
      status: HomePageStatus.success,
      tutors: [
        ...state.tutors,
        ...tutors,
      ],
      canLoadMore: pagination.canNext,
    );
  }

  Future<void> searchTutor(String? search) async {
    pagination = Pagination();
    final tutorList = await repository.getTutorList(
      page: pagination.firstPage,
      perPage: pagination.limit,
      filter: state.filter.where,
      search: search,
    );
    state = state.copyWith(
      status: HomePageStatus.success,
      tutors: tutorList,
      canLoadMore: pagination.canNext,
    );
  }

  void applyFilter(TutorListFilter filter) {
    state = state.copyWith(
      status: HomePageStatus.filterChanged,
      filter: filter,
    );
  }
}
