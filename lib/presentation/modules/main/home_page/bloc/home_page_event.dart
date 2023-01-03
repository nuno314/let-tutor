part of 'home_page_bloc.dart';

abstract class HomePageEvent {}

class InitialHomePageEvent extends HomePageEvent {}

class GetDataEvent extends HomePageEvent {}

class LoadMoreDataEvent extends HomePageEvent {}

class FilterChangedEvent extends HomePageEvent {
  final TutorListFilter filter;

  FilterChangedEvent(this.filter);
}

class SearchTutorEvent extends HomePageEvent {
  final String? value;

  SearchTutorEvent(this.value);
}

class FavoriteTutorEvent extends HomePageEvent {
  final String? id;

  FavoriteTutorEvent(this.id);
}
