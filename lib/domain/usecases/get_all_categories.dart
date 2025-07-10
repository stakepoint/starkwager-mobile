import '../models/category.dart';
import '../repositories/category_repository.dart';

class GetAllCategories {
  final CategoryRepository repository;

  GetAllCategories(this.repository);

  Future<CategoriesResponse> call() async {
    return await repository.getAllCategories();
  }
}
