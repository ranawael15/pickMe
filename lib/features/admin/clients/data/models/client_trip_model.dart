class ClientTripModel {
  final String id;
  final String userId;
  final String destinationId;
  final String destinationName;
  final double budget;
  final String status;
  final DateTime? tripDate;
  final DateTime? createdAt;

  const ClientTripModel({
    required this.id,
    required this.userId,
    required this.destinationId,
    required this.destinationName,
    required this.budget,
    required this.status,
    this.tripDate,
    this.createdAt,
  });

  factory ClientTripModel.fromJson(Map<String, dynamic> json) {
    return ClientTripModel(
      id: json['id']?.toString() ?? '',
      userId: json['user_id']?.toString() ?? '',
      destinationId: json['destination_id']?.toString() ?? '',
      destinationName: json['destination_name'] ?? '',
      budget: (json['budget'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] ?? '',
      tripDate: json['trip_date'] != null
          ? DateTime.tryParse(json['trip_date'].toString())
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
    );
  }
}