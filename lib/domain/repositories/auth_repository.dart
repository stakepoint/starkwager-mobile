import '../models/auth_response.dart';

abstract class AuthRepository {
  Future<AuthResponse> createLogin(String address);
}
