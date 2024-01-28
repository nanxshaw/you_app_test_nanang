
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/api/api_service.dart';
import 'package:test/models/user_models.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ApiService apiService;
  final SharedPreferences sharedPreferences;

  UserBloc({required this.apiService,required this.sharedPreferences}) : super(UserInitial()) {
    on<GetProfileEvent>(_mapGetProfileEventToState);
    on<UpdateProfileEvent>(_mapUpdateProfileEventToState);
  }

  _mapGetProfileEventToState(
      GetProfileEvent event, Emitter<UserState> emit) async {
    try {
      final token = sharedPreferences.getString('token');
      final headers = {'x-access-token':token  };
      final response = await apiService.request(
        'getProfile',
        method: 'GET',
        headers: headers,
      );

      if (response.statusCode == 200) {
        final UserModel data = UserModel.fromJson(response.data);
        emit(ProfileSuccess(user: data));
      } else {
        emit(ProfileFailure(error: 'Gagal get profile'));
      }
    } catch (e) {
      emit(ProfileFailure(error: 'Gagal get profile. $e'));
    }
  }

  _mapUpdateProfileEventToState(
      UpdateProfileEvent event, Emitter<UserState> emit) async {
    try {
      final headers = {
        'x-access-token':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1YjI1MjdhMjM0YzQ2ZTk3MmQxZmIzOCIsInVzZXJuYW1lIjoidGVzdDEyMyIsImVtYWlsIjoidGVzdDEyM0B0ZXN0LmNvbSIsImlhdCI6MTcwNjM4MTg2NiwiZXhwIjoxNzA2Mzg1NDY2fQ.lrVpUDWeFG1aZwmBzrsTj6fRGAKPZLtgRsiYiGQkn6U'
      };
      final response = await apiService.request(
        'updateProfile',
        method: 'GET',
        data: {
          'name': event.name,
          'birthday': event.birthday,
          'height': event.height,
          'weight': event.weight,
          'interests': event.interests,
        },
        headers: headers,
      );

      if (response.statusCode == 200) {
        emit(UpdateProfileSuccess());
      } else {
        emit(UpdateProfileFailure(error: 'Gagal update profile'));
      }
    } catch (e) {
      emit(UpdateProfileFailure(error: 'Gagal update profile. $e'));
    }
  }
}
