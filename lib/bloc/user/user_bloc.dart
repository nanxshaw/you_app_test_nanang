
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

  UserBloc({required this.apiService, required this.sharedPreferences})
      : super(UserInitial()) {
    on<GetProfileEvent>(_mapGetProfileEventToState);
    on<CreateProfileEvent>(_mapCreateProfileEventToState);
    on<UpdateProfileEvent>(_mapUpdateProfileEventToState);
    on<UpdateInterestEvent>(_mapUpdateInterestEventToState);
  }

  _mapGetProfileEventToState(
      GetProfileEvent event, Emitter<UserState> emit) async {
    try {
      final token = sharedPreferences.getString('token');
      final headers = {'x-access-token': token};
      final response = await apiService.request(
        'getProfile',
        method: 'GET',
        headers: headers,
      );
      if (response.statusCode == 200) {
        final gender = sharedPreferences.getString("gender");
        final image = sharedPreferences.getString('image64');
        final UserModel data = UserModel.fromJson(response.data);
        emit(ProfileSuccess(user: data, gender: gender, image: image));
      } else {
        emit(ProfileFailure(error: 'Gagal get profile'));
      }
    } catch (e) {
      emit(ProfileFailure(error: 'Gagal get profile. $e'));
    }
  }

  _mapCreateProfileEventToState(
      CreateProfileEvent event, Emitter<UserState> emit) async {
    try {
      final token = sharedPreferences.getString('token');
      final headers = {'x-access-token': token};
      final response = await apiService.request(
        'createProfile',
        method: 'POST',
        data: {
          'name': event.name,
          'birthday': event.birthday,
          'height': event.height,
          'weight': event.weight,
          'interests': [],
        },
        headers: headers,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        sharedPreferences.setString('gender', event.gender.toString());
        sharedPreferences.setString('image64', event.image.toString());
        final res = await apiService.request(
          'getProfile',
          method: 'GET',
          headers: headers,
        );
        final UserModel data = UserModel.fromJson(res.data);
        emit(ProfileSuccess(user: data, gender: event.gender, image: event.image));
      } else {
        emit(UpdateProfileFailure(error: 'Gagal update profile'));
      }
    } catch (e) {
      emit(UpdateProfileFailure(error: 'Gagal update profile. $e'));
    }
  }

  _mapUpdateProfileEventToState(
      UpdateProfileEvent event, Emitter<UserState> emit) async {
    try {
      final token = sharedPreferences.getString('token');
      final headers = {'x-access-token': token};
      final response = await apiService.request(
        'updateProfile',
        method: 'PUT',
        data: {
          'name': event.name,
          'birthday': event.birthday,
          'height': event.height,
          'weight': event.weight,
        },
        headers: headers,
      );
      if (response.statusCode == 200) {
        sharedPreferences.setString('gender', event.gender.toString());
        sharedPreferences.setString('image64', event.image.toString());
        final res = await apiService.request(
          'getProfile',
          method: 'GET',
          headers: headers,
        );
        final UserModel data = UserModel.fromJson(res.data);
        emit(ProfileSuccess(user: data, gender: event.gender, image: event.image));
      } else {
        emit(UpdateProfileFailure(error: 'Gagal update profile'));
      }
    } catch (e) {
      emit(UpdateProfileFailure(error: 'Gagal update profile. $e'));
    }
  }

  _mapUpdateInterestEventToState(
      UpdateInterestEvent event, Emitter<UserState> emit) async {
    try {
      final token = sharedPreferences.getString('token');
      final headers = {'x-access-token': token};
      final response = await apiService.request(
        'updateProfile',
        method: 'PUT',
        data: {
          'interests': event.interests,
        },
        headers: headers,
      );
      if (response.statusCode == 200) {
        final gender = sharedPreferences.getString("gender");
        final image = sharedPreferences.getString('image64');
        final res = await apiService.request(
          'getProfile',
          method: 'GET',
          headers: headers,
        );
        final UserModel data = UserModel.fromJson(res.data);
        emit(ProfileSuccess(user: data, gender: gender, image: image));
      } else {
        emit(UpdateProfileFailure(error: 'Gagal update profile'));
      }
    } catch (e) {
      emit(UpdateProfileFailure(error: 'Gagal update profile. $e'));
    }
  }
}
