import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../core/network/api_client.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/create_login.dart';
import '../states/auth_state.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(ref.read(dioProvider));
});

final authRemoteDatasourceProvider = Provider<AuthRemoteDatasource>((ref) {
  return AuthRemoteDatasourceImpl(ref.read(apiClientProvider));
});

final authRepositoryProvider = Provider((ref) {
  return AuthRepositoryImpl(ref.read(authRemoteDatasourceProvider));
});

final createLoginUseCaseProvider = Provider((ref) {
  return CreateLogin(ref.read(authRepositoryProvider));
});

class AuthNotifier extends StateNotifier<AuthState> {
  final CreateLogin createLogin;
  AuthNotifier(this.createLogin) : super(AuthInitial());

  Future<void> createLoginWithAddress(String address) async {
    state = AuthLoading();
    try {
      final response = await createLogin(address);
      state = AuthSuccess(response);
    } catch (e) {
      state = AuthFailure(e.toString());
    }
  }
}

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.read(createLoginUseCaseProvider));
});
