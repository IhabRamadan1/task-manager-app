import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/core/network_services/remote/dio_helper.dart';
import 'package:task_manager_app/core/network_services/end_points.dart';
import 'package:task_manager_app/data/apis_models/auth_model.dart';
import 'package:task_manager_app/data/apis_models/get_current_user_model.dart';
import 'package:task_manager_app/data/apis_models/refresh_token_model.dart';

import 'auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  bool isVisible = false;

  void visibilityPasswordChange() {
    isVisible = !isVisible;
    emit(AuthVisibilityState());
  }

  AuthModel? authModel;

  void login({
    required String username,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final response = await DioHelper.postData(
        url: loginUserEndPoint,
        data: {
          "username": username,
          "password": password,
          "expiresInMins": 30,
        },
      );
      authModel = AuthModel.fromJson(response.data);
      final token = response.data['token'];
      final refreshToken = response.data['refreshToken'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setString('refreshToken', refreshToken);
      emit(AuthSuccess(authModel: authModel!));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  RefreshTokenModel? refreshTokenModel;

  Future<void> getRefreshToken() async {
    emit(RefreshLoading());
    try {
      final response = await DioHelper.postData(
        url: refreshTokenEndPoint,
        data: {
          "refreshToken": await _getRefreshToken(),
          "expiresInMins": 30,
        },
      );
      refreshTokenModel = RefreshTokenModel.fromJson(response.data);
      final token = response.data['token'];
      final refreshToken = response.data['refreshToken'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setString('refreshToken', refreshToken);
      emit(RefreshSuccess());
    } catch (e) {
      emit(RefreshFailure(e.toString()));
    }
  }

  GetCurrentUserModel? getCurrentUserModel;

  void getUser(context) async {
    emit(GetUserLoading());
    try {
      final response = await DioHelper.getData(url: getCurrentUserEndPoint);
      if (response.data["name"] == "JsonWebTokenError") {
        await getRefreshToken();
        final retryResponse = await DioHelper.getData(url: getCurrentUserEndPoint);
        getCurrentUserModel = GetCurrentUserModel.fromJson(retryResponse.data);
        emit(GetUserSuccess());
      } else {
        getCurrentUserModel = GetCurrentUserModel.fromJson(response.data);
        emit(GetUserSuccess());
      }
    } catch (e) {
      emit(GetUserFailure(e.toString()));
    }
  }

  Future<String?> _getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('refreshToken');
  }
}
