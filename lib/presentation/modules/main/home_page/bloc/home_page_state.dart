part of 'home_page_bloc.dart';

class _ViewModel {
  final List<Teacher> tutors;
  final TutorListFilter? tutorFilter;
  final List<BookingInfo> upcomingLessons;
  final bool canLoadMore;

  const _ViewModel({
    this.tutorFilter = const TutorListFilter(),
    this.canLoadMore = false,
    this.tutors = const [],
    this.upcomingLessons = const [],
  });

  _ViewModel copyWith({
    List<Teacher>? tutors,
    bool? canLoadMore,
    List<BookingInfo>? upcomingLessons,
    TutorListFilter? tutorFilter,
  }) {
    return _ViewModel(
      tutors: tutors ?? this.tutors,
      canLoadMore: canLoadMore ?? this.canLoadMore,
      upcomingLessons: upcomingLessons ?? this.upcomingLessons,
      tutorFilter: tutorFilter ?? this.tutorFilter,
    );
  }
}

abstract class HomePageState {
  final _ViewModel viewModel;

  HomePageState(this.viewModel);

  T copyWith<T extends HomePageState>({
    _ViewModel? viewModel,
  }) {
    return _factories[T == HomePageState ? runtimeType : T]!(
      viewModel ?? this.viewModel,
    );
  }

  List<Teacher> get tutors => viewModel.tutors;
  List<BookingInfo> get upcomingLessons => viewModel.upcomingLessons;
  TutorListFilter? get tutorFilter => viewModel.tutorFilter;
}

class HomePageInitial extends HomePageState {
  HomePageInitial({
    _ViewModel viewModel = const _ViewModel(),
  }) : super(viewModel);
}

final _factories = <
    Type,
    Function(
  _ViewModel viewModel,
)>{
  HomePageInitial: (viewModel) => HomePageInitial(
        viewModel: viewModel,
      ),
};
