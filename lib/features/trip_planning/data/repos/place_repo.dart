import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/place_model.dart';
import '../models/planner_request.dart';

class PlaceRepository {
  final SupabaseClient supabase;

  PlaceRepository({required this.supabase});

  Future<List<PlaceModel>> fetchPlaces(PlannerRequest request) async {
    if (request.selectedCategoryIds.isEmpty) {
      return [];
    }

    final response = await supabase
        .from('places')
        .select()
        .eq('destination_id', request.destinationId)
        .inFilter('category_id', request.selectedCategoryIds);

    final places = (response as List)
        .map((json) => PlaceModel.fromJson(json as Map<String, dynamic>))
        .toList();

    return places;
  }
}
