import 'place_model.dart';

class GeneratedPlan {
  final String name;
  final List<PlaceModel> places;
  final double budget;

  const GeneratedPlan({
    required this.name,
    required this.places,
    required this.budget,
  });

  double get totalCost {
    return places.fold(0, (sum, place) => sum + place.estimatedCost);
  }

  double get remainingBudget {
    return budget - totalCost;
  }
}
