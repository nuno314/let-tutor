part of 'dashboard_bloc.dart';

abstract class DashboardEvent {}

class GetDataEvent extends DashboardEvent {}

class LoadMoreDataEvent extends DashboardEvent {}