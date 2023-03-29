part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent {}

class ResetByPhoneNumberEvent extends ResetPasswordEvent {
  final String phoneNumber;

  ResetByPhoneNumberEvent(this.phoneNumber);
}

class ResetByEmailEvent extends ResetPasswordEvent {
  final String email;

  ResetByEmailEvent(this.email);
}
