import '../../domain/models/auth_response.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {
  final AuthResponse response;
  AuthSuccess(this.response);
}
class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}
