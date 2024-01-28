part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginFailure extends AuthState {
  final String error;

  LoginFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class RegisterSuccess extends AuthState {}

class RegisterFailure extends AuthState {
  final String error;

  RegisterFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
