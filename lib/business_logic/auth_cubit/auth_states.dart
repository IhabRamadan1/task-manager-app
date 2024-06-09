
import 'package:task_manager_app/data/apis_models/auth_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

//login states
class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final AuthModel authModel;

  AuthSuccess({required this.authModel});
}

class AuthFailure extends AuthState {
  final String errMessage;

  AuthFailure(this.errMessage);
}

// Refresh token
class RefreshLoading extends AuthState {}

class RefreshSuccess extends AuthState {
  // final AuthModel authModel;

  // RefreshSuccess({required this.authModel});
}

class RefreshFailure extends AuthState {
  final String errMessage;

  RefreshFailure(this.errMessage);
}

class AuthVisibilityState extends AuthState{}

//get current user states

class GetUserLoading extends AuthState {}

class GetUserSuccess extends AuthState {}

class GetUserFailure extends AuthState {
  final String errMessage;

  GetUserFailure(this.errMessage);
}