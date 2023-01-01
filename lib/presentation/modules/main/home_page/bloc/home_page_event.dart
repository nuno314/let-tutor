part of 'home_page_bloc.dart';

abstract class HomePageEvent {}

class InitialHomePageEvent extends HomePageEvent {}

class GetDataEvent extends HomePageEvent {}

class LoadMoreDataEvent extends HomePageEvent {}
