part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String username;
  final String password;

  LoginEvent({
    required this.email,
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [email, username, password];
}

class RegisterEvent extends AuthEvent {
  final String email;
  final String username;
  final String password;
  final String password_confirm;

  RegisterEvent({
    required this.email,
    required this.username,
    required this.password,
    required this.password_confirm
  });

  @override
  List<Object?> get props => [email, username, password,password_confirm];
}

class GetProfileEvent extends AuthEvent {}

class UpdateProfileEvent extends AuthEvent {
  final String name;
  final String birthday;
  final int height;
  final int weight;
  final List<String> interests;

  UpdateProfileEvent({
    required this.name,
    required this.birthday,
    required this.height,
    required this.weight,
    required this.interests,
  });

  @override
  List<Object?> get props => [name, birthday, height, weight, interests];
}
