import 'package:starkwager/core/network/api_client.dart';

abstract class AvnuRemoteDataSource {
  Future<Map<String, dynamic>> deployAccount(
      {required String userAddress,
      required String classHash,
      required String salt,
      required String unique,
      required List<String> calldata,
      required List<String> sigdata});
}

class AvnuRemoteDataSourceImpl implements AvnuRemoteDataSource {
  final ApiClient apiClient;
  AvnuRemoteDataSourceImpl(this.apiClient);
  @override
  Future<Map<String, dynamic>> deployAccount(
      {required String userAddress,
      required String classHash,
      required String salt,
      required String unique,
      required List<String> calldata,
      required List<String> sigdata}) async {
    final ref = await apiClient.post(
      '/paymaster/v1/deploy-account',
      data: {
        "userAddress": userAddress,
        "deploymentData": {
          "class_hash": classHash,
          "salt": salt,
          "unique": unique,
          "calldata": calldata,
          "sigdata": sigdata
        }
      },
    );
    return ref.data;
  }
}
