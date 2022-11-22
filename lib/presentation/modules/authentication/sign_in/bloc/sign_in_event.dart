part of 'sign_in_bloc.dart';

abstract class SignInEvent {}

class SignInByEmailEvent extends SignInEvent {
  final String? email;
  final String? password;

  SignInByEmailEvent({this.email, this.password});
}

class SignInByFacebookEvent extends SignInEvent {
  final String accessToken;

  SignInByFacebookEvent({required this.accessToken});
}

class SignInByGoogleEvent extends SignInEvent {
  final String accessToken;

  SignInByGoogleEvent({required this.accessToken});
}