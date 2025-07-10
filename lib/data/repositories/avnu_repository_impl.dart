import 'package:avnu_provider/avnu_provider.dart';
import 'package:starkwager/data/datasources/avnu_remote_datasource.dart';
import 'package:starkwager/domain/repositories/avnu_repository.dart';

class AvnuRepositoryImpl implements AvnuRepository {
  late AvnuProvider _avnuProvider;
  late AvnuReadProvider _avnuReadProvider;
  final AvnuRemoteDataSource _avnuRemoteDataSource;

  AvnuRepositoryImpl({required AvnuRemoteDataSource avnuRemoteDataSource}) : _avnuRemoteDataSource = avnuRemoteDataSource {
    _initialize();
  }

  void _initialize() {
    _avnuProvider = AvnuJsonRpcProvider(
      nodeUri: Uri.parse("https://starknet-sepolia.public.blastapi.io"),
      apiKey: String.fromEnvironment('API_KEY'),
    );
    _avnuReadProvider = AvnuJsonRpcReadProvider(
      nodeUri: Uri.parse("https://starknet-sepolia.public.blastapi.io"),
      apiKey: String.fromEnvironment('API_KEY'),
    );
  }

  @override
  Future<void> deployAccount({
    required String userAddress,
    required String classHash,
    required String salt,
    required String unique,
    required List<String> calldata,
    required List<String> sigdata,
  }) async {
    await _avnuRemoteDataSource.deployAccount(
      userAddress: userAddress,
      classHash: classHash,
      salt: salt,
      unique: unique,
      calldata: calldata,
      sigdata: sigdata,
    );
  }

  @override
  Future<AvnuAccountRewards> setUserLimit(
      {required String address,
      required String campaign,
      required String protocol,
      required int freeTx,
      required DateTime expirationDate,
      required List<Map<String, String>> whitelistedCalls}) async {
    return await _avnuProvider.setAccountRewards(
      address,
      campaign,
      protocol,
      freeTx,
      expirationDate.toIso8601String(),
      whitelistedCalls,
    );
  }

  @override
  Future<AvnuBuildTypedData> registerTypedData(
      {required String userAddress,
      required List<Map<String, dynamic>> calls,
      required String gasTokenAddress,
      required String maxGasTokenAmount,
      required String accountClassHash}) async {
    return await _avnuProvider.buildTypedData(userAddress, calls, gasTokenAddress, maxGasTokenAmount, accountClassHash);
  }

  @override
  Future<AvnuExecute> executeContract(
      {required String userAddress, required String typedData, required List<String> signature, Map<dynamic, dynamic>? deploymentData}) async {
    return await _avnuProvider.execute(userAddress, typedData, signature, deploymentData);
  }

  @override
  Future<AvnuGasTokenPrices> getGasTokenPrices() async {
    return await _avnuReadProvider.getGasTokenPrices();
  }

  @override
  Future<bool> checkAccountCompatibility({required String userAddress}) async {
    final ref = await _avnuReadProvider.checkAccountCompatible(userAddress);
    return ref is AvnuAccountCompatibleIsCompatible ? true : false;
  }
}
