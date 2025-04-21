import '../../domain/models/auth_response.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;
  AuthRepositoryImpl(this.remoteDatasource);

  @override
  Future<AuthResponse> createLogin(String address) {
    return remoteDatasource.createLogin(address);
  }
}
