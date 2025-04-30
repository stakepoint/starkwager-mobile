class Hashtag {
  final String id;
  final String name;
  final String createdAt;
  final String updatedAt;

  Hashtag({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Hashtag.fromJson(Map<String, dynamic> json) => Hashtag(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        createdAt: json['createdAt'] ?? '',
        updatedAt: json['updatedAt'] ?? '',
      );
}

class HashtagsResponse {
  final List<Hashtag> hashtags;

  HashtagsResponse({required this.hashtags});

  factory HashtagsResponse.fromJson(dynamic json) {
    // Handle both array response and object with data field
    List<dynamic> hashtagsData = [];

    if (json is List) {
      // Direct array response
      hashtagsData = json;
    } else if (json is Map<String, dynamic>) {
      // Response with data field
      hashtagsData = json['data'] ?? [];
    }

    final hashtags = hashtagsData
        .map((hashtagJson) => Hashtag.fromJson(hashtagJson))
        .toList();
    return HashtagsResponse(hashtags: hashtags);
  }
}
