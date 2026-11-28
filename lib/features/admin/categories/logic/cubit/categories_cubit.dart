import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/category_model.dart';
import '../../data/repos/categories_repo.dart';
import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoriesRepository repository;

  CategoriesCubit({required this.repository}) : super(const CategoriesState()) {
    loadData();
  }

  // Load categories and destinations from Supabase.
  Future<void> loadData() async {
    emit(state.copyWith(isLoading: true, clearError: true));

    try {
      final results = await Future.wait([
        repository.getCategories(),
        repository.getDestinations(),
      ]);

      emit(
        state.copyWith(
          categories: results[0] as List<CategoryModel>,
          destinations: results[1] as List<Map<String, dynamic>>,
          isLoading: false,
          clearError: true,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  // Search categories.
  void searchCategories(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  // Filter categories by destination.
  void filterByDestination(String? destinationId) {
    emit(
      state.copyWith(
        selectedDestinationId: destinationId,
        resetDestinationFilter: destinationId == null,
      ),
    );
  }

  // Add category.
  Future<void> addCategory({
    required String name,
    required String description,
    required List<String> destinationIds,
  }) async {
    await _performMutation(() {
      return repository.addCategory(
        name: name,
        description: description,
        destinationIds: destinationIds,
      );
    });
  }

  // Update category.
  Future<void> updateCategory({
    required String categoryId,
    required String name,
    required String description,
    required List<String> destinationIds,
  }) async {
    await _performMutation(() {
      return repository.updateCategory(
        categoryId: categoryId,
        name: name,
        description: description,
        destinationIds: destinationIds,
      );
    });
  }

  // Delete category.
  Future<void> deleteCategory(String categoryId) async {
    await _performMutation(() {
      return repository.deleteCategory(categoryId);
    });
  }

  // Execute mutation and reload data.
  Future<void> _performMutation(Future<void> Function() action) async {
    emit(state.copyWith(isLoading: true, clearError: true));

    try {
      await action();
      await loadData();
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
      rethrow;
    }
  }
}
