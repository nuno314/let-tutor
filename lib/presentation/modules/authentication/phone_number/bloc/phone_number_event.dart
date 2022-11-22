part of 'phone_number_bloc.dart';

abstract class PhoneNumberEvent {}

class SignInByPhoneNumberEvent extends PhoneNumberEvent {
  final String phoneNumber;
  final String password;

  SignInByPhoneNumberEvent({
    required this.phoneNumber,
    required this.password,
  });
}
