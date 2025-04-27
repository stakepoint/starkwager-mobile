import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/category.dart';
import '../../../domain/usecases/get_all_categories.dart';

// Category States
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final CategoriesResponse categories;
  CategoryLoaded(this.categories);
}

class CategoryError extends CategoryState {
  final String message;
  CategoryError(this.message);
}

// Category Notifier
class CategoriesNotifier extends StateNotifier<CategoryState> {
  final GetAllCategories getAllCategories;

  CategoriesNotifier(this.getAllCategories) : super(CategoryInitial()) {
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      state = CategoryLoading();
      final categories = await getAllCategories();
      state = CategoryLoaded(categories);
    } catch (e) {
      state = CategoryError(e.toString());
    }
  }
} 