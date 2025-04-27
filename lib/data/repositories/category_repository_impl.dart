import '../../domain/models/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_remote_datasource.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDatasource remoteDatasource;
  
  CategoryRepositoryImpl(this.remoteDatasource);
  
  @override
  Future<CategoriesResponse> getAllCategories() {
    return remoteDatasource.getAllCategories();
  }
} 