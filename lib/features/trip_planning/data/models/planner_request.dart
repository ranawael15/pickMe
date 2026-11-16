class PlannerRequest {
  final String destinationId;
  final double budget;
  final List<String> selectedCategoryIds;

  const PlannerRequest({
    required this.destinationId,
    required this.budget,
    required this.selectedCategoryIds,
  });
}
