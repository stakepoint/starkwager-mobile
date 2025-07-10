import '../models/hashtag.dart';

abstract class HashtagRepository {
  Future<HashtagsResponse> getAllHashtags();
}
