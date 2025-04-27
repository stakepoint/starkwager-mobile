import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/api_client.dart';
import '../../../data/datasources/category_remote_datasource.dart';
import '../../../data/repositories/category_repository_impl.dart';
import '../../../domain/models/category.dart';
import '../../../domain/usecases/get_all_categories.dart';
import '../state/category_state.dart';

final selectedCategoryProvider = StateProvider<String?>((ref) => null);

// Provider to supply the GetAllCategories use case
final getAllCategoriesUseCaseProvider = Provider((ref) {
  final apiClient = ref.read(apiClientProvider);
  final remoteDatasource = CategoryRemoteDatasourceImpl(apiClient, ref);
  final repository = CategoryRepositoryImpl(remoteDatasource);
  return GetAllCategories(repository);
});

// State notifier to handle category loading state
final categoriesNotifierProvider =
    StateNotifierProvider<CategoriesNotifier, CategoryState>((ref) {
  final getAllCategories = ref.read(getAllCategoriesUseCaseProvider);
  return CategoriesNotifier(getAllCategories);
});

// Provider to expose just the list of category names for UI consumption
final categoriesProvider = Provider<List<String>>((ref) {
  final state = ref.watch(categoriesNotifierProvider);

  if (state is CategoryLoaded) {
    return state.categories.categories
        .map((category) => category.name)
        .toList();
  } else {
    // Fallback if categories haven't loaded yet
    return [
      'Sports',
      'ESports',
      'Politics',
      'Crypto',
      'Stocks',
      'Entertainment',
      'Games',
      'Others'
    ];
  }
});
