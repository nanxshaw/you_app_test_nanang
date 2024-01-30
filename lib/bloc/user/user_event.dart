part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class GetProfileEvent extends UserEvent {}

class CreateProfileEvent extends UserEvent {
  final String? name;
  final String? birthday;
  final int? height;
  final int? weight;
  final String? horoscope;
  final String? zodiac;
  final List<String>? interests;
  final String? gender;
  final String? image;

  CreateProfileEvent({
    this.name,
    this.birthday,
    this.height,
    this.weight,
    this.interests,
    this.horoscope,
    this.zodiac,
    this.gender,
    this.image,
  });

  @override
  List<Object?> get props =>
      [name, birthday, height, weight, interests, gender, image];
}

class UpdateProfileEvent extends UserEvent {
  final String? name;
  final String? birthday;
  final int? height;
  final int? weight;
  final String? horoscope;
  final String? zodiac;
  final List<String>? interests;
  final String? gender;
  final String? image;

  UpdateProfileEvent({
    this.name,
    this.birthday,
    this.height,
    this.weight,
    this.interests,
    this.horoscope,
    this.zodiac,
    this.gender,
    this.image,
  });

  @override
  List<Object?> get props =>
      [name, birthday, height, weight, interests, gender, image];
}

class UpdateInterestEvent extends UserEvent {
  final List<String>? interests;

  UpdateInterestEvent({
    this.interests,
  });

  @override
  List<Object?> get props => [interests];
}
