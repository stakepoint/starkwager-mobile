import '../models/auth_response.dart';
import '../repositories/auth_repository.dart';

class CreateLogin {
  final AuthRepository repository;
  CreateLogin(this.repository);

  Future<AuthResponse> call(String address) {
    return repository.createLogin(address);
  }
}
