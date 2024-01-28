import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/api/api_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ApiService apiService;
  final SharedPreferences sharedPreferences;

  AuthBloc({required this.apiService, required this.sharedPreferences})
      : super(AuthInitial()) {
    on<LoginEvent>(_LoginEventState);
    on<RegisterEvent>(_RegisterEventState);
  }

  _LoginEventState(event, emit) async {
    try {
      final response = await apiService.request(
        'login',
        method: 'POST',
        data: {
          'email': event.email,
          'username': event.username,
          'password': event.password,
        },
      );
      if (response.statusCode == 201) {
        // simpan data lokal
        sharedPreferences.setString('token', response.data['access_token']);
        sharedPreferences.setString(
          'user',
          jsonEncode(
            {
              'email': "test123@test.com",
              'username': 'test123',
              'password': 'testing123',
            },
          ),
        );
        emit(LoginSuccess());
      } else {
        emit(LoginFailure(error: 'Gagal login'));
      }
    } catch (e) {
      emit(LoginFailure(error: 'Gagal login. $e'));
    }
  }

  _RegisterEventState(RegisterEvent event, Emitter<AuthState> emit) async {
    try {
      if (event.password == event.password_confirm) {
        final response = await apiService.request(
          'register',
          method: 'POST',
          data: {
            'email': event.email,
            'username': event.username,
            'password': event.password,
          },
        );
        if (response.statusCode == 201) {
          emit(RegisterSuccess());
        } else {
          emit(RegisterFailure(error: 'Gagal register'));
        }
      } else {
        emit(RegisterFailure(error: 'Password tidak sama'));
      }
    } catch (e) {
      emit(RegisterFailure(error: 'Gagal register. $e'));
    }
  }
}
