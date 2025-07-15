import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starkwager/core/network/api_client.dart';
import 'package:starkwager/data/datasources/avnu_remote_datasource.dart';
import 'package:starkwager/data/repositories/avnu_repository_impl.dart';
import 'package:starkwager/domain/repositories/avnu_repository.dart';

final avnuRemoteDataSourceProvider = Provider<AvnuRemoteDataSource>((ref) {
  return AvnuRemoteDataSourceImpl(
      ApiClient(Dio(BaseOptions(baseUrl: "https://sepolia.api.avnu.fi/"))));
});

final avnuRepositoryProvider = Provider<AvnuRepository>((ref) {
  final remoteDataSource = ref.watch(avnuRemoteDataSourceProvider);
  return AvnuRepositoryImpl(avnuRemoteDataSource: remoteDataSource);
});
