import '../../core/network/api_client.dart';
import '../../domain/models/auth_response.dart';
import 'package:dio/dio.dart';
import '../../core/error/failures.dart';

abstract class AuthRemoteDatasource {
  Future<AuthResponse> createLogin(String address);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final ApiClient apiClient;
  AuthRemoteDatasourceImpl(this.apiClient);

  @override
  Future<AuthResponse> createLogin(String address) async {
    try {
      final response = await apiClient
          .post('/auth/create-login', data: {'address': address});
      final data = response.data as Map<String, dynamic>;
      if (data['tokens'] == null) {
        throw ServerFailure(
          message: data['message'] ?? 'Unknown error',
          code: response.statusCode,
        );
      }
      if (data['user'] == null) {
        data['user'] = {
          'id': '',
          'email': null,
          'username': null,
          'address': address,
          'picture': null,
          'isVerified': false,
          'roles': 'User',
          'createdAt': DateTime.now().toIso8601String(),
          'updatedAt': DateTime.now().toIso8601String(),
        };
      }
      return AuthResponse.fromJson(data);
    } on DioException catch (e) {
      throw ServerFailure(
        message: e.message ?? 'An error occurred during login',
        code: e.response?.statusCode,
      );
    } catch (e) {
      if (e is ServerFailure) {
        rethrow;
      }
      throw ServerFailure(message: e.toString());
    }
  }
}
