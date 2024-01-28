part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class LoginSuccess extends UserState {}

class LoginFailure extends UserState {
  final String error;

  LoginFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class RegisterSuccess extends UserState {}

class RegisterFailure extends UserState {
  final String error;

  RegisterFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class ProfileSuccess extends UserState {
  final UserModel user;

  ProfileSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

class ProfileFailure extends UserState {
  final String error;

  ProfileFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class UpdateProfileSuccess extends UserState {}

class UpdateProfileFailure extends UserState {
  final String error;

  UpdateProfileFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
