part of 'sign_up_bloc.dart';

abstract class SignUpEvent {}

class SignUpByEmailEvent extends SignUpEvent {
  final String? email;
  final String? password;

  SignUpByEmailEvent({
    this.email,
    this.password,
  });
}
