import '../../domain/models/hashtag.dart';
import '../../domain/repositories/hashtag_repository.dart';
import '../datasources/hashtag_remote_datasource.dart';

class HashtagRepositoryImpl implements HashtagRepository {
  final HashtagRemoteDatasource remoteDatasource;

  HashtagRepositoryImpl(this.remoteDatasource);

  @override
  Future<HashtagsResponse> getAllHashtags() {
    return remoteDatasource.getAllHashtags();
  }
}
