class CategoryModel {
  final String id;
  final String name;
  final String? description;
  final String? imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<String> destinationIds;

  const CategoryModel({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
    this.destinationIds = const [],
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    final relations = json['destination_categories'] as List<dynamic>? ?? [];

    return CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      imageUrl: json['image_url'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      destinationIds: relations
          .map((item) => item['destination_id'] as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'description': description, 'image_url': imageUrl};
  }

  CategoryModel copyWith({
    String? name,
    String? description,
    String? imageUrl,
    List<String>? destinationIds,
  }) {
    return CategoryModel(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt,
      updatedAt: updatedAt,
      destinationIds: destinationIds ?? this.destinationIds,
    );
  }
}
