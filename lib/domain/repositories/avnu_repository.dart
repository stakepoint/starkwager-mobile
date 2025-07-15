import 'package:avnu_provider/avnu_provider.dart';

abstract class AvnuRepository {
  Future<void> deployAccount({
    required String userAddress,
    required String classHash,
    required String salt,
    required String unique,
    required List<String> calldata,
    required List<String> sigdata,
  });

  Future<AvnuAccountRewards> setUserLimit(
      {required String address,
      required String campaign,
      required String protocol,
      required int freeTx,
      required DateTime expirationDate,
      required List<Map<String, String>> whitelistedCalls});

  Future<AvnuBuildTypedData> registerTypedData(
      {required String userAddress,
      required List<Map<String, dynamic>> calls,
      required String gasTokenAddress,
      required String maxGasTokenAmount,
      required String accountClassHash});

  Future<AvnuExecute> executeContract(
      {required String userAddress,
      required String typedData,
      required List<String> signature,
      Map<dynamic, dynamic>? deploymentData});

  Future<AvnuGasTokenPrices> getGasTokenPrices();

  Future<bool> checkAccountCompatibility({required String userAddress});
}
