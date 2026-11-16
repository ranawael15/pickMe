class PlaceModel {
  final String id;
  final String destinationId;
  final String categoryId;
  final String name;
  final String? description;
  final String? imageUrl;
  final double estimatedCost;

  const PlaceModel({
    required this.id,
    required this.destinationId,
    required this.categoryId,
    required this.name,
    this.description,
    this.imageUrl,
    required this.estimatedCost,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json['id'],
      destinationId: json['destination_id'],
      categoryId: json['category_id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['image_url'],
      estimatedCost: (json['estimated_cost'] as num).toDouble(),
    );
  }
}
