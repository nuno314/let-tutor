part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent {}

class ChangePasswordEventImpl extends ChangePasswordEvent {
  final String password;
  final String newPassword;

  ChangePasswordEventImpl({
    required this.password,
    required this.newPassword,
  });
}
