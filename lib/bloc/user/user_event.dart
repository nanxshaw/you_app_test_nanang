part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class GetProfileEvent extends UserEvent {}

class UpdateProfileEvent extends UserEvent {
  final String? name;
  final String? birthday;
  final int? height;
  final int? weight;
  final List<String>? interests;

  UpdateProfileEvent(
      {this.name, this.birthday, this.height, this.weight, this.interests});

  @override
  List<Object?> get props => [name, birthday, height, weight, interests];
}
