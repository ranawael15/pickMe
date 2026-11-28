import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/category_model.dart';
import '../../logic/cubit/categories_cubit.dart';
import '../../logic/cubit/categories_state.dart';
import '../widgets/category_card.dart';
import '../widgets/category_search_bar.dart';
import '../widgets/destination_filter.dart';
import 'category_form_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  static const Color background = Color(0xFFF0E8DF);
  static const Color primary = Color(0xFFF8DB69);
  static const Color dark = Color(0xFF302419);
  static const Color muted = Color(0xFF716453);

  @override
  Widget build(BuildContext context) {
    return const _CategoriesView();
  }
}

class _CategoriesView extends StatelessWidget {
  const _CategoriesView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CategoriesScreen.background,
      body: SafeArea(
        child: BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state) {
            final categories = state.filteredCategories;

            return Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 25, 20, 18),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Categories',
                              style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                                color: CategoriesScreen.dark,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Manage experience categories linked to \ndestinations',
                              style: TextStyle(
                                fontSize: 12,
                                height: 1.4,
                                color: CategoriesScreen.muted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CategoryFormScreen(
                                cubit: context.read<CategoriesCubit>(),
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.add, size: 17),
                        label: const Text(
                          'Add',
                          style: TextStyle(fontSize: 12),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: CategoriesScreen.primary,
                          foregroundColor: const Color(0xFF806600),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 13,
                          ),
                          shape: const StadiumBorder(),
                        ),
                      ),
                    ],
                  ),
                ),

                // Search
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CategorySearchBar(
                    onChanged: context.read<CategoriesCubit>().searchCategories,
                  ),
                ),

                const SizedBox(height: 20),

                // Destination Filter
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: DestinationFilter(
                    destinations: state.destinations,
                    selectedDestinationId: state.selectedDestinationId,
                    totalCategories: state.categories.length,
                    getCategoryCount: state.getCategoryCount,
                    onDestinationSelected: context
                        .read<CategoriesCubit>()
                        .filterByDestination,
                  ),
                ),

                const SizedBox(height: 20),

                // Categories List
                Expanded(child: _buildContent(context, state, categories)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    CategoriesState state,
    List<CategoryModel> categories,
  ) {
    if (state.isLoading && state.categories.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: CategoriesScreen.primary),
      );
    }

    if (state.errorMessage != null && state.categories.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                size: 40,
                color: Colors.redAccent,
              ),
              const SizedBox(height: 12),
              const Text(
                'Something went wrong',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: CategoriesScreen.dark,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                state.errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11,
                  color: CategoriesScreen.muted,
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  context.read<CategoriesCubit>().loadData();
                },
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      );
    }

    if (categories.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.category_outlined,
                size: 45,
                color: CategoriesScreen.muted.withOpacity(0.5),
              ),
              const SizedBox(height: 12),
              const Text(
                'No categories found',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: CategoriesScreen.dark,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Try another search or add a new category.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: CategoriesScreen.muted),
              ),
            ],
          ),
        ),
      );
    }

    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 25),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];

            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: CategoryCard(
                category: category,
                onEdit: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CategoryFormScreen(
                        cubit: context.read<CategoriesCubit>(),
                        category: category,
                      ),
                    ),
                  );
                },
                onDelete: () {
                  _confirmDelete(context, category);
                },
              ),
            );
          },
        ),

        if (state.isLoading)
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: LinearProgressIndicator(
              color: CategoriesScreen.primary,
              minHeight: 2,
            ),
          ),
      ],
    );
  }

  void _confirmDelete(BuildContext context, CategoryModel category) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: CategoriesScreen.background,
          title: const Text('Delete Category?'),
          content: Text('Are you sure you want to delete ${category.name}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(dialogContext);

                try {
                  await context.read<CategoriesCubit>().deleteCategory(
                    category.id,
                  );

                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Category deleted successfully'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } catch (e) {
                  if (!context.mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Delete failed: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
