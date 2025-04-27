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

  factory HashtagsResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> hashtagsData = json['data'] ?? [];
    final hashtags = hashtagsData
        .map((hashtagJson) => Hashtag.fromJson(hashtagJson))
        .toList();
    return HashtagsResponse(hashtags: hashtags);
  }
} 