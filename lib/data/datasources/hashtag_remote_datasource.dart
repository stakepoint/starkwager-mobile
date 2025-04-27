import 'package:dio/dio.dart';
import '../../core/error/failures.dart';
import '../../core/network/api_client.dart';
import '../../domain/models/hashtag.dart';
import '../../presentation/providers/auth_provider.dart';
import '../../presentation/states/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class HashtagRemoteDatasource {
  Future<HashtagsResponse> getAllHashtags();
}

class HashtagRemoteDatasourceImpl implements HashtagRemoteDatasource {
  final ApiClient apiClient;
  final Ref ref;

  HashtagRemoteDatasourceImpl(this.apiClient, this.ref);

  @override
  Future<HashtagsResponse> getAllHashtags() async {
    try {
      // Check if the user is authenticated
      final authState = ref.read(authNotifierProvider);
      if (authState is! AuthSuccess) {
        throw ServerFailure(
          message: 'Authentication required to fetch hashtags',
        );
      }

      // Get the access token
      final token = authState.response.tokens.accessToken;

      // Make the API request with the token
      final response = await apiClient.get(
        '/hashtags',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final data = response.data as Map<String, dynamic>;
      return HashtagsResponse.fromJson(data);
    } on DioException catch (e) {
      throw ServerFailure(
        message: e.message ?? 'An error occurred while fetching hashtags',
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
