import 'dart:math';

import '../data/models/generated_plan.dart';
import '../data/models/place_model.dart';
import '../data/models/planner_request.dart';

class PlannerService {
  final Random _random = Random();

  List<GeneratedPlan> generatePlans({
    required List<PlaceModel> places,
    required PlannerRequest request,
  }) {
    // Validate the request.
    if (request.budget <= 0 ||
        request.selectedCategoryIds.isEmpty ||
        places.isEmpty) {
      return [];
    }

    // Group places by the selected categories and destination.
    final Map<String, List<PlaceModel>> placesByCategory = {};

    for (final categoryId in request.selectedCategoryIds) {
      final categoryPlaces = places
          .where((place) => place.destinationId == request.destinationId)
          .where((place) => place.categoryId == categoryId)
          .where((place) => place.estimatedCost <= request.budget)
          .toList();

      if (categoryPlaces.isEmpty) {
        return [];
      }

      placesByCategory[categoryId] = categoryPlaces;
    }

    // Start with categories that have fewer available places.
    final categories = request.selectedCategoryIds.toList()
      ..sort(
        (a, b) =>
            placesByCategory[a]!.length.compareTo(placesByCategory[b]!.length),
      );

    // Shuffle places to generate different combinations.
    for (final categoryId in categories) {
      placesByCategory[categoryId]!.shuffle(_random);
    }

    final List<GeneratedPlan> generatedPlans = [];

    final Set<String> usedCombinations = {};

    final List<PlaceModel> selectedPlaces = [];

    const int maxPlans = 3;
    const int maxSearchNodes = 10000;

    int searchNodes = 0;

    void searchPlans(int categoryIndex, double currentCost) {
      if (generatedPlans.length >= maxPlans || searchNodes >= maxSearchNodes) {
        return;
      }

      searchNodes++;

      // A complete plan has been created.
      if (categoryIndex == categories.length) {
        final combinationKey = selectedPlaces.map((place) => place.id).toList()
          ..sort();

        final key = combinationKey.join('|');

        if (usedCombinations.contains(key)) {
          return;
        }

        usedCombinations.add(key);

        final planNames = ['Plan A', 'Plan B', 'Plan C'];

        generatedPlans.add(
          GeneratedPlan(
            name: planNames[generatedPlans.length],
            places: List.unmodifiable(selectedPlaces),
            budget: request.budget,
          ),
        );

        return;
      }

      final categoryId = categories[categoryIndex];

      final categoryPlaces = placesByCategory[categoryId]!;

      for (final place in categoryPlaces) {
        final newTotal = currentCost + place.estimatedCost;

        // Never allow a plan to exceed the user's budget.
        if (newTotal > request.budget) {
          continue;
        }

        selectedPlaces.add(place);

        searchPlans(categoryIndex + 1, newTotal);

        selectedPlaces.removeLast();

        if (generatedPlans.length >= maxPlans ||
            searchNodes >= maxSearchNodes) {
          return;
        }
      }
    }

    searchPlans(0, 0);

    return generatedPlans;
  }
}
