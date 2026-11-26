
class FeedbackModel {
  final String? id;
  final String tripId;
  final String userId;
  final String userName;
  final int rating;
  final String comment;
  final DateTime createdAt;

  const FeedbackModel({
    this.id,
    required this.tripId,
    required this.userId,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  // Convert Supabase data into a FeedbackModel object.
  factory FeedbackModel.fromMap(Map<String, dynamic> map) {
    return FeedbackModel(
      id: map['id']?.toString(),
      tripId: map['trip_id'].toString(),
      userId: map['user_id'].toString(),
      userName: map['user_name'] ?? 'Anonymous',
      rating: (map['rating'] as num).toInt(),
      comment: map['comment'] ?? '',
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  // Convert FeedbackModel object into data for Supabase.
  Map<String, dynamic> toMap() {
    return {
      'trip_id': tripId,
      'user_id': userId,
      'user_name': userName,
      'rating': rating,
      'comment': comment,
    };
  }
}
