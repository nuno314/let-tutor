part of 'histories_bloc.dart';

abstract class HistoriesEvent {}

class GetDataEvent extends HistoriesEvent {}

class LoadMoreDataEvent extends HistoriesEvent {}