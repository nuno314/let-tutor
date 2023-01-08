part of 'register_tutor_bloc.dart';

abstract class RegisterTutorEvent {}

class RegisterTutorSuccessEvent extends RegisterTutorEvent {
  final String? bio;
  final String? education;
  final String? birthday;
  final String? experience;
  final String? interests;
  final String? languages;
  final String? profression;
  final int rating = 0;
  final String? specialties;
  final String? targetStudent;
  final int price = 50000;
  final String? avatar;

  RegisterTutorSuccessEvent({
    this.bio,
    this.education,
    this.experience,
    this.interests,
    this.languages,
    this.profression,
    this.specialties,
    this.targetStudent,
    this.birthday,
    this.avatar,
  });
}
