import 'package:dio/dio.dart';
import '../../core/error/failures.dart';
import '../../core/network/api_client.dart';
import '../../domain/models/category.dart';
import '../../presentation/providers/auth_provider.dart';
import '../../presentation/states/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class CategoryRemoteDatasource {
  Future<CategoriesResponse> getAllCategories();
}

class CategoryRemoteDatasourceImpl implements CategoryRemoteDatasource {
  final ApiClient apiClient;
  final Ref ref;

  CategoryRemoteDatasourceImpl(this.apiClient, this.ref);

  @override
  Future<CategoriesResponse> getAllCategories() async {
    try {
      // Check if the user is authenticated
      final authState = ref.read(authNotifierProvider);
      if (authState is! AuthSuccess) {
        throw ServerFailure(
          message: 'Authentication required to fetch categories',
        );
      }

      // Get the access token
      final token = authState.response.tokens.accessToken;

      // Make the API request with the token
      final response = await apiClient.get(
        '/categories/all',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      // Pass the direct response data to the fromJson method
      return CategoriesResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure(
        message: e.message ?? 'An error occurred while fetching categories',
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
