import '../models/hashtag.dart';
import '../repositories/hashtag_repository.dart';

class GetAllHashtags {
  final HashtagRepository repository;

  GetAllHashtags(this.repository);

  Future<HashtagsResponse> call() async {
    return await repository.getAllHashtags();
  }
} 