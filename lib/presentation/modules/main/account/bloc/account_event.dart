part of 'account_bloc.dart';

abstract class AccountEvent {}

class GetDataEvent extends AccountEvent {}

class LoadMoreDataEvent extends AccountEvent {}