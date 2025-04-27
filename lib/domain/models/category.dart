class Category {
  final String id;
  final String name;
  final String createdAt;
  final String updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        createdAt: json['createdAt'] ?? '',
        updatedAt: json['updatedAt'] ?? '',
      );
}

class CategoriesResponse {
  final List<Category> categories;

  CategoriesResponse({required this.categories});

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> categoriesData = json['data'] ?? [];
    final categories = categoriesData
        .map((categoryJson) => Category.fromJson(categoryJson))
        .toList();
    return CategoriesResponse(categories: categories);
  }
} 