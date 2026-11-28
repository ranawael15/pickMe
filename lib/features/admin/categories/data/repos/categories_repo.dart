import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/category_model.dart';

class CategoriesRepository {
  final SupabaseClient supabase;

  CategoriesRepository({required this.supabase});

  // Get all categories with their related destinations.
  Future<List<CategoryModel>> getCategories() async {
    final response = await supabase
        .from('categories')
        .select('*, destination_categories(destination_id)')
        .order('created_at', ascending: false);

    return (response as List)
        .map((item) => CategoryModel.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  // Get destinations from Supabase.
  Future<List<Map<String, dynamic>>> getDestinations() async {
    final response = await supabase
        .from('destinations')
        .select('id, name')
        .order('name');

    return (response as List)
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
  }

  // Add a new category and link it to selected destinations.
  Future<void> addCategory({
    required String name,
    required String description,
    required List<String> destinationIds,
  }) async {
    final categoryResponse = await supabase
        .from('categories')
        .insert({'name': name, 'description': description})
        .select('id')
        .single();

    final categoryId = categoryResponse['id'] as String;

    if (destinationIds.isNotEmpty) {
      final relations = destinationIds.map((destinationId) {
        return {'category_id': categoryId, 'destination_id': destinationId};
      }).toList();

      await supabase.from('destination_categories').insert(relations);
    }
  }

  // Update category information and its destination relations.
  Future<void> updateCategory({
    required String categoryId,
    required String name,
    required String description,
    required List<String> destinationIds,
  }) async {
    await supabase
        .from('categories')
        .update({
          'name': name,
          'description': description,
          'updated_at': DateTime.now().toUtc().toIso8601String(),
        })
        .eq('id', categoryId);

    // Remove old relations.
    await supabase
        .from('destination_categories')
        .delete()
        .eq('category_id', categoryId);

    // Add new relations.
    if (destinationIds.isNotEmpty) {
      final relations = destinationIds.map((destinationId) {
        return {'category_id': categoryId, 'destination_id': destinationId};
      }).toList();

      await supabase.from('destination_categories').insert(relations);
    }
  }

  // Delete a category.
  Future<void> deleteCategory(String categoryId) async {
    await supabase.from('categories').delete().eq('id', categoryId);
  }
}
