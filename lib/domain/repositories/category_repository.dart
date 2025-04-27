import '../models/category.dart';

abstract class CategoryRepository {
  Future<CategoriesResponse> getAllCategories();
} 