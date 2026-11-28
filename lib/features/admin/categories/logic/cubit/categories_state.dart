import '../../data/models/category_model.dart';

class CategoriesState {
  final List<CategoryModel> categories;
  final List<Map<String, dynamic>> destinations;

  final String searchQuery;
  final String? selectedDestinationId;

  final bool isLoading;
  final String? errorMessage;

  const CategoriesState({
    this.categories = const [],
    this.destinations = const [],
    this.searchQuery = '',
    this.selectedDestinationId,
    this.isLoading = false,
    this.errorMessage,
  });

  // Filter categories by search query and selected destination.
  List<CategoryModel> get filteredCategories {
    return categories.where((category) {
      final matchesSearch =
          searchQuery.trim().isEmpty ||
          category.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          (category.description ?? '').toLowerCase().contains(
            searchQuery.toLowerCase(),
          );

      final matchesDestination =
          selectedDestinationId == null ||
          category.destinationIds.contains(selectedDestinationId);

      return matchesSearch && matchesDestination;
    }).toList();
  }

  // Get categories count for a destination.
  int getCategoryCount(String? destinationId) {
    if (destinationId == null) {
      return categories.length;
    }

    return categories.where((category) {
      return category.destinationIds.contains(destinationId);
    }).length;
  }

  CategoriesState copyWith({
    List<CategoryModel>? categories,
    List<Map<String, dynamic>>? destinations,
    String? searchQuery,
    String? selectedDestinationId,
    bool resetDestinationFilter = false,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return CategoriesState(
      categories: categories ?? this.categories,
      destinations: destinations ?? this.destinations,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedDestinationId: resetDestinationFilter
          ? null
          : selectedDestinationId ?? this.selectedDestinationId,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
